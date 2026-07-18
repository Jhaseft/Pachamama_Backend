import {
  BadRequestException,
  ConflictException,
  Inject,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { UsersService } from '../users/users.service';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import { UserEntity } from '../users/entities/user.entity';
import { CACHE_MANAGER } from '@nestjs/cache-manager';
import type { Cache } from 'cache-manager';
import { randomInt } from 'crypto';
import type { User } from '@prisma/client';
import { CompleteRegistrationDto } from './dto/complete-registration.dto';
import { CompleteAnfitrioneRegistrationDto } from './dto/complete-anfitrione-registration.dto';
import { WhatsappService } from '../whatsapp/whatsapp.service';
import { MailService } from '../mail/mail.service';
import { ResetPasswordDto } from './dto/reset-password.dto';
import { PrismaService } from '../../prisma/prisma.service';
import { CloudinaryService } from '../cloudinary/cloudinary.service';
import { ReferralsService } from '../referrals/referrals.service';
import { GoogleAuthService } from '../google-auth/google-auth.service';
import { CompleteGoogleClientProfileDto } from './dto/complete-google-client-profile.dto';
import { CompleteGoogleAnfitrioneProfileDto } from './dto/complete-google-anfitriona-profile.dto';
import { SetPasswordDto } from './dto/set-password.dto';

@Injectable()
export class AuthService {
  constructor(
    private usersService: UsersService,
    private jwtService: JwtService,
    @Inject(CACHE_MANAGER) private cacheManager: Cache,
    private whatsappService: WhatsappService,
    private mailService: MailService,
    private prisma: PrismaService,
    private cloudinary: CloudinaryService,
    private referralsService: ReferralsService,
    private googleAuthService: GoogleAuthService,
  ) {}

  // ─── OTP FLOW ─────────────────────────────────────────────────────────────

  async sendOtp(email: string) {
    const normalizedEmail = email.trim().toLowerCase();
    const code = randomInt(0, 1000000).toString().padStart(6, '0');
    await this.cacheManager.set(`otp_${normalizedEmail}`, code, 300000); // 5 min

    await this.mailService.sendOtpEmail(normalizedEmail, code);

    return { message: 'Código OTP enviado a tu correo. Expira en 5 minutos.' };
  }

  async verifyOtp(email: string, code: string) {
    const normalizedEmail = email.trim().toLowerCase();
    const cached = await this.cacheManager.get<string>(`otp_${normalizedEmail}`);

    if (!cached || cached !== code) {
      throw new BadRequestException('Código OTP inválido o expirado');
    }

    await this.cacheManager.del(`otp_${normalizedEmail}`);

    const user = await this.usersService.findOneByEmail(normalizedEmail);

    if (user) {
      // Usuario existente → retornar JWT
      const { password: _, ...userWithoutPass } = user;
      return this.generateTokenResponse(userWithoutPass);
    }

    // Usuario nuevo → retornar token temporal para completar el registro
    const tempToken = this.jwtService.sign(
      { sub: normalizedEmail, type: 'email_verified' },
      { expiresIn: '10m' },
    );

    return { needsProfile: true, tempToken };
  }

  // ─── GOOGLE LOGIN ─────────────────────────────────────────────────────────

  // METODO PARA LOGIN CON GOOGLE DESDE LA APP MÓVIL (VERIFICA ID TOKEN EMITIDO POR LA APP)
  async googleLogin(idToken: string) {
    const { email, firstName, lastName } = await this.googleAuthService.verifyIdToken(idToken);

    const existing = await this.usersService.findOneByEmail(email);

    if (existing) {
      if (existing.role === 'ANFITRIONA') {
        throw new ConflictException('Este correo está registrado como anfitriona. Usa el acceso de anfitrionas.');
      }
      const { password: _, ...userWithoutPass } = existing;
      return this.generateTokenResponse(userWithoutPass);
    }

    // La cuenta queda lista de una vez: el nombre viene de Google (o se deriva
    // del correo si Google no lo envía) y la contraseña se deja vacía (null),
    // ya que el acceso es por Google. No se pide completar perfil.
    const newUser = await this.usersService.create({
      email,
      firstName: firstName?.trim() || email.split('@')[0],
      lastName,
      isProfileComplete: true,
    });

    const { password: _, ...userWithoutPass } = newUser;
    return this.generateTokenResponse(userWithoutPass);
  }

  // METODO PARA LOGIN CON GOOGLE DESDE LA APP MÓVIL, PERO SOLO PARA ANFITRIONAS (VERIFICA ID TOKEN EMITIDO
  async googleLoginAnfitriona(idToken: string) {
    const { email, firstName, lastName } = await this.googleAuthService.verifyIdToken(idToken);

    const existing = await this.usersService.findOneByEmail(email);

    if (existing) {
      if (existing.role !== 'ANFITRIONA') {
        throw new ConflictException('Este correo ya está registrado como usuario cliente.');
      }
      const { password: _, ...userWithoutPass } = existing;
      return this.generateTokenResponse(userWithoutPass);
    }

    const newUser = await this.prisma.user.create({
      data: {
        email,
        firstName,
        lastName,
        role: 'ANFITRIONA',
        isProfileComplete: false,
        wallet: { create: { balance: 0 } },
      },
    });

    const { password: _, ...userWithoutPass } = newUser;
    return this.generateTokenResponse(userWithoutPass);
  }

  // METODO PARA COMPLETAR PERFIL DE USUARIO QUE HIZO GOOGLE LOGIN DESDE LA APP MÓVIL
  async completeGoogleClientProfile(
    userId: string,
    dto: CompleteGoogleClientProfileDto,
  ) {
    if (dto.password !== dto.confirmPassword) {
      throw new BadRequestException('Las contraseñas no coinciden');
    }

    const hashedPassword = await bcrypt.hash(dto.password, 10);

    const updated = await this.usersService.update(userId, {
      firstName: dto.firstName,
      lastName: dto.lastName,
      phoneNumber: dto.phoneNumber,
      password: hashedPassword,
      isProfileComplete: true,
    });

    const { password: _, ...userWithoutPass } = updated;
    return this.generateTokenResponse(userWithoutPass);
  }

  // METODO PARA COMPLETAR PERFIL DE ANFITRIONA QUE HIZO GOOGLE LOGIN DESDE LA APP MÓVIL
  async completeGoogleAnfitrioneProfile(
    userId: string,
    dto: CompleteGoogleAnfitrioneProfileDto,
    idDocFile?: Express.Multer.File,
  ) {
    const [existingCedula, existingUsername] = await Promise.all([
      this.prisma.anfitrioneProfile.findUnique({ where: { cedula: dto.cedula } }),
      this.prisma.anfitrioneProfile.findUnique({ where: { username: dto.username } }),
    ]);

    if (existingCedula) throw new ConflictException('La cédula ya está registrada.');
    if (existingUsername) throw new ConflictException('El nombre de usuario ya está en uso.');

    let idDocUrl: string | null = null;
    let idDocPublicId: string | null = null;

    if (idDocFile) {
      const uploaded = await this.cloudinary.uploadAnfitrioneIdDoc({
        file: idDocFile,
        userId,
      });
      idDocUrl = uploaded.secureUrl;
      idDocPublicId = uploaded.publicId;
    }

    await this.prisma.anfitrioneProfile.create({
      data: {
        userId,
        dateOfBirth: new Date(dto.dateOfBirth),
        cedula: dto.cedula,
        username: dto.username,
        idDocUrl,
        idDocPublicId,
      },
    });

    const updated = await this.usersService.update(userId, {
      firstName: dto.firstName,
      lastName: dto.lastName,
      isProfileComplete: true,
    });

    if (dto.referralCode) {
      await this.referralsService.createPendingCreatorReferralFromCode({
        referredCreatorId: userId,
        referralCode: dto.referralCode,
      });
    }

    const { password: _, ...userWithoutPass } = updated;
    return this.generateTokenResponse(userWithoutPass);
  }

  async completeRegistration(dto: CompleteRegistrationDto) {
    // Validar token temporal
    let payload: { sub: string; type: string };
    try {
      payload = this.jwtService.verify(dto.tempToken);
    } catch {
      throw new BadRequestException('Token inválido o expirado');
    }

    if (payload.type !== 'email_verified') {
      throw new BadRequestException('Token inválido');
    }

    if (dto.password !== dto.confirmPassword) {
      throw new BadRequestException('Las contraseñas no coinciden');
    }

    const email = payload.sub;

    const existing = await this.usersService.findOneByEmail(email);
    if (existing) {
      throw new ConflictException('El email ya está registrado');
    }

    const hashedPassword = await bcrypt.hash(dto.password, 10);

    const newUser = await this.usersService.create({
      email,
      firstName: dto.firstName,
      lastName: dto.lastName,
      password: hashedPassword,
      isProfileComplete: true,
    });

    await this.referralsService.tryLinkReferralCodeToUser(
      newUser.id,
      dto.referralCode,
    );

    const { password: _, ...userWithoutPass } = newUser;
    return this.generateTokenResponse(userWithoutPass);
  }

  async completeAnfitrioneRegistration(
    dto: CompleteAnfitrioneRegistrationDto,
    idDocFile?: Express.Multer.File,
  ) {
    // 1. Validar token temporal
    let payload: { sub: string; type: string };
    try {
      payload = this.jwtService.verify(dto.tempToken);
    } catch {
      throw new BadRequestException('Token inválido o expirado');
    }

    if (payload.type !== 'email_verified') {
      throw new BadRequestException('Token inválido');
    }

    if (dto.password !== dto.confirmPassword) {
      throw new BadRequestException('Las contraseñas no coinciden');
    }

    if (dto.referralCode) {
      await this.referralsService.validateCreatorReferralCode(dto.referralCode);
    }

    const email = payload.sub;

    // 2. Verificar unicidad
    const [existingCedula, existingUsername, existingEmail] = await Promise.all([
      this.prisma.anfitrioneProfile.findUnique({ where: { cedula: dto.cedula } }),
      this.prisma.anfitrioneProfile.findUnique({ where: { username: dto.username } }),
      this.usersService.findOneByEmail(email),
    ]);

    if (existingCedula) throw new ConflictException('La cédula ya está registrada.');
    if (existingUsername) throw new ConflictException('El nombre de usuario ya está en uso.');
    if (existingEmail) throw new ConflictException('El email ya está registrado.');

    // 3. Crear usuario con rol ANFITRIONA
    const hashedPassword = await bcrypt.hash(dto.password, 10);

    const newUser = await this.prisma.user.create({
      data: {
        email,
        firstName: dto.firstName,
        lastName: dto.lastName,
        password: hashedPassword,
        role: 'ANFITRIONA',
        isProfileComplete: true,
        wallet: { create: { balance: 0 } },
      },
    });

    // 4. Subir DNI a Cloudinary si se proporcionó
    let idDocUrl: string | null = null;
    let idDocPublicId: string | null = null;

    if (idDocFile) {
      const uploaded = await this.cloudinary.uploadAnfitrioneIdDoc({
        file: idDocFile,
        userId: newUser.id,
      });
      idDocUrl = uploaded.secureUrl;
      idDocPublicId = uploaded.publicId;
    }

    // 5. Crear perfil de anfitriona
    const profile = await this.prisma.anfitrioneProfile.create({
      data: {
        userId: newUser.id,
        dateOfBirth: new Date(dto.dateOfBirth),
        cedula: dto.cedula,
        username: dto.username,
        idDocUrl,
        idDocPublicId,
      },
    });

    await this.referralsService.createPendingCreatorReferralFromCode({
      referredCreatorId: newUser.id,
      referralCode: dto.referralCode,
    });

    const { password: _, ...userWithoutPass } = newUser;
    return {
      ...this.generateTokenResponse(userWithoutPass),
      profile,
    };
  }

  // ─── EMAIL/PASSWORD LOGIN (secundario) ────────────────────────────────────

  async validateUser(
    email: string,
    pass: string,
  ): Promise<Omit<User, 'password'> | null> {
    const user = await this.usersService.findOneByEmail(email);
    if (user && user.password && (await bcrypt.compare(pass, user.password))) {
      const { password: _, ...result } = user;
      return result;
    }
    return null;
  }

  login(user: Omit<User, 'password'>) {
    return this.generateTokenResponse(user);
  }

  // ─── SET PASSWORD (usuarios Google sin contraseña) ────────────────────────

  // METODO PARA QUE USUARIOS QUE HICIERON LOGIN CON GOOGLE DESDE LA APP MÓVIL PUEDAN ESTABLECER UNA CONTRASEÑA Y ASÍ TENER LA OPCIÓN DE LOGIN TRADICIONAL SI LO DESEAN
  async setPassword(userId: string, dto: SetPasswordDto) {
    if (dto.password !== dto.confirmPassword) {
      throw new BadRequestException('Las contraseñas no coinciden');
    }

    const user = await this.usersService.findOneById(userId);
    if (!user) throw new NotFoundException('Usuario no encontrado');
    if (user.password) {
      throw new BadRequestException(
        'Ya tienes una contraseña. Usa la opción de cambiar contraseña.',
      );
    }

    const hashedPassword = await bcrypt.hash(dto.password, 10);
    await this.usersService.update(userId, { password: hashedPassword });

    return { message: 'Contraseña guardada correctamente' };
  }

  // ─── FORGOT PASSWORD ──────────────────────────────────────────────────────

  async forgotPassword(email: string) {
    const normalizedEmail = email.trim().toLowerCase();
    const user = await this.usersService.findOneByEmail(normalizedEmail);

    // Siempre respondemos igual para no revelar si el email existe
    if (!user || !user.email) {
      return { message: 'Si el correo está registrado, recibirás un código.' };
    }

    const code = randomInt(0, 1000000).toString().padStart(6, '0');
    await this.cacheManager.set(`reset_${normalizedEmail}`, code, 900000); // 15 min

    await this.mailService.sendPasswordResetEmail(
      user.email,
      user.firstName ?? 'Usuario',
      code,
    );

    return { message: 'Si el correo está registrado, recibirás un código.' };
  }

  async resetPassword(dto: ResetPasswordDto) {
    const normalizedEmail = dto.email.trim().toLowerCase();
    const cached = await this.cacheManager.get<string>(`reset_${normalizedEmail}`);

    if (!cached || cached !== dto.code) {
      throw new BadRequestException('Código inválido o expirado');
    }

    const user = await this.usersService.findOneByEmail(normalizedEmail);
    if (!user) {
      throw new NotFoundException('Usuario no encontrado');
    }

    const hashedPassword = await bcrypt.hash(dto.newPassword, 10);
    await this.usersService.update(user.id, { password: hashedPassword });
    await this.cacheManager.del(`reset_${normalizedEmail}`);

    return { message: 'Contraseña actualizada correctamente' };
  }

  // ─── HELPERS ──────────────────────────────────────────────────────────────

  private generateTokenResponse(user: Omit<User, 'password'>) {
    this.usersService.updateLastLogin(user.id);
    this.usersService.updateLastActive(user.id);

    const payload = {
      sub: user.id,
      phoneNumber: user.phoneNumber,
      email: user.email,
      role: user.role,
      isProfileComplete: user.isProfileComplete,
    };

    return {
      access_token: this.jwtService.sign(payload),
      user: new UserEntity(user),
    };
  }
}


