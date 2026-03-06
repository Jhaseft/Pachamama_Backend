import {
  Controller,
  Post,
  Body,
  UnauthorizedException,
  HttpCode,
  HttpStatus,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { LoginDto } from './dto/login.dto';
import { SendOtpDto } from './dto/send-otp.dto';
import { VerifyOtpDto } from './dto/verify-otp.dto';
import { CompleteRegistrationDto } from './dto/complete-registration.dto';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  // ─── FLUJO OTP ────────────────────────────────────────────────────────────

  // Pantalla 6: Ingresar número de celular → enviar OTP
  @Post('send-otp')
  async sendOtp(@Body() dto: SendOtpDto) {
    return this.authService.sendOtp(dto.phoneNumber);
  }

  // Pantalla 7: Verificar código OTP
  // Respuesta A: { access_token, user }           → usuario existente (login)
  // Respuesta B: { needsProfile: true, tempToken } → usuario nuevo (ir a completar perfil)
  @Post('verify-otp')
  @HttpCode(HttpStatus.OK)
  async verifyOtp(@Body() dto: VerifyOtpDto) {
    return this.authService.verifyOtp(dto.phoneNumber, dto.code);
  }

  // Pantalla 8: Completar perfil (solo usuarios nuevos)
  @Post('complete-registration')
  async completeRegistration(@Body() dto: CompleteRegistrationDto) {
    return this.authService.completeRegistration(dto);
  }

  // ─── LOGIN EMAIL/PASSWORD (secundario) ───────────────────────────────────

  @Post('login')
  @HttpCode(HttpStatus.OK)
  async login(@Body() loginDto: LoginDto) {
    const user = await this.authService.validateUser(
      loginDto.email,
      loginDto.password,
    );
    if (!user) {
      throw new UnauthorizedException('Email o contraseña incorrectos');
    }
    return this.authService.login(user);
  }
}
