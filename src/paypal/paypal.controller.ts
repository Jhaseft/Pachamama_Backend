import { Body, Controller, Post, UseGuards } from '@nestjs/common';
import { ApiTags, ApiBearerAuth, ApiOperation } from '@nestjs/swagger';
import { IsString, IsUUID, Length } from 'class-validator';
import { PaypalService } from './paypal.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { CurrentUser } from '../auth/decorators/current-user.decorator';

class CreatePaypalOrderDto {
  @IsUUID()
  packageId: string;
}

class CapturePaypalOrderDto {
  @IsString()
  @Length(1, 64)
  orderId: string;
}

@ApiTags('PayPal')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('paypal')
export class PaypalController {
  constructor(private readonly paypalService: PaypalService) {}

  @Post('create-order')
  @ApiOperation({ summary: 'Crear orden PayPal y obtener URL de aprobación' })
  createOrder(
    @CurrentUser() user: { userId: string },
    @Body() dto: CreatePaypalOrderDto,
  ) {
    return this.paypalService.createPayment(user.userId, dto.packageId);
  }

  @Post('capture')
  @ApiOperation({ summary: 'Capturar orden PayPal y acreditar créditos' })
  capture(
    @CurrentUser() user: { userId: string },
    @Body() dto: CapturePaypalOrderDto,
  ) {
    return this.paypalService.capturePayment(user.userId, dto.orderId);
  }
}
