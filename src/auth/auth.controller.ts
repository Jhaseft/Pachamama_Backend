import {
  Controller,
  Post,
  Body,
  UnauthorizedException,
  HttpCode,
  HttpStatus,
  UseInterceptors,
  UploadedFile,
  UseGuards,
  Request,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { ApiConsumes, ApiTags } from '@nestjs/swagger';
import { AuthService } from './auth.service';
import { LoginDto } from './dto/login.dto';
import { SendOtpDto } from './dto/send-otp.dto';
import { VerifyOtpDto } from './dto/verify-otp.dto';
import { CompleteRegistrationDto } from './dto/complete-registration.dto';
import { CompleteAnfitrioneRegistrationDto } from './dto/complete-anfitrione-registration.dto';
import { ForgotPasswordDto } from './dto/forgot-password.dto';
import { GoogleLoginDto } from './dto/google-login.dto';
import { CompleteGoogleClientProfileDto } from './dto/complete-google-client-profile.dto';
import { CompleteGoogleAnfitrioneProfileDto } from './dto/complete-google-anfitriona-profile.dto';
import { SetPasswordDto } from './dto/set-password.dto';
import { JwtAuthGuard } from './guards/jwt-auth.guard';
import { ResetPasswordDto } from './dto/reset-password.dto';

@ApiTags('Auth')
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('send-otp')
  async sendOtp(@Body() dto: SendOtpDto) {
    return this.authService.sendOtp(dto.email);
  }

  @Post('verify-otp')
  @HttpCode(HttpStatus.OK)
  async verifyOtp(@Body() dto: VerifyOtpDto) {
    return this.authService.verifyOtp(dto.email, dto.code);
  }

  @Post('complete-registration')
  async completeRegistration(@Body() dto: CompleteRegistrationDto) {
    return this.authService.completeRegistration(dto);
  }

  @Post('complete-anfitrione-registration')
  @ApiConsumes('multipart/form-data')
  @UseInterceptors(FileInterceptor('idDoc'))
  async completeAnfitrioneRegistration(
    @Body() dto: CompleteAnfitrioneRegistrationDto,
    @UploadedFile() idDoc?: Express.Multer.File,
  ) {
    return this.authService.completeAnfitrioneRegistration(dto, idDoc);
  }


  @Post('google-login')
  @HttpCode(HttpStatus.OK)
  async googleLogin(@Body() dto: GoogleLoginDto) {
    return this.authService.googleLogin(dto.idToken);
  }

  @Post('google-login-anfitriona')
  @HttpCode(HttpStatus.OK)
  async googleLoginAnfitriona(@Body() dto: GoogleLoginDto) {
    return this.authService.googleLoginAnfitriona(dto.idToken);
  }

  @Post('complete-google-client-profile')
  @HttpCode(HttpStatus.OK)
  @UseGuards(JwtAuthGuard)
  async completeGoogleClientProfile(
    @Request() req: any,
    @Body() dto: CompleteGoogleClientProfileDto,
  ) {
    return this.authService.completeGoogleClientProfile(req.user.userId, dto);
  }

  @Post('complete-google-anfitriona-profile')
  @HttpCode(HttpStatus.OK)
  @UseGuards(JwtAuthGuard)
  @ApiConsumes('multipart/form-data')
  @UseInterceptors(FileInterceptor('idDoc'))
  async completeGoogleAnfitrioneProfile(
    @Request() req: any,
    @Body() dto: CompleteGoogleAnfitrioneProfileDto,
    @UploadedFile() idDoc?: Express.Multer.File,
  ) {
    return this.authService.completeGoogleAnfitrioneProfile(req.user.userId, dto, idDoc);
  }

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

  @Post('set-password')
  @HttpCode(HttpStatus.OK)
  @UseGuards(JwtAuthGuard)
  async setPassword(@Request() req: any, @Body() dto: SetPasswordDto) {
    return this.authService.setPassword(req.user.userId, dto);
  }

  @Post('forgot-password')
  @HttpCode(HttpStatus.OK)
  async forgotPassword(@Body() dto: ForgotPasswordDto) {
    return this.authService.forgotPassword(dto.email);
  }

  @Post('reset-password')
  @HttpCode(HttpStatus.OK)
  async resetPassword(@Body() dto: ResetPasswordDto) {
    return this.authService.resetPassword(dto);
  }
}
