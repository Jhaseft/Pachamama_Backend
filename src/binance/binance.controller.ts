import {
  Body,
  Controller,
  Get,
  Param,
  Post,
  UseGuards,
} from '@nestjs/common';
import { ApiTags, ApiBearerAuth, ApiOperation } from '@nestjs/swagger';
import { IsString, IsUUID, Length } from 'class-validator';
import { BinanceService } from './binance.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { CurrentUser } from '../auth/decorators/current-user.decorator';

class CreateBinanceIntentDto {
  @IsUUID()
  packageId: string;
}

class ConfirmBinanceIntentDto {
  @IsUUID()
  intentId: string;

  @IsString()
  @Length(10, 200)
  txid: string;
}

@ApiTags('Binance')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('binance')
export class BinanceController {
  constructor(private readonly binanceService: BinanceService) {}

  @Post('intent')
  @ApiOperation({
    summary: 'Crea un intent de depósito Binance (wallet, monto y expiración)',
  })
  createIntent(
    @CurrentUser() user: { userId: string },
    @Body() dto: CreateBinanceIntentDto,
  ) {
    return this.binanceService.createIntent(user.userId, dto.packageId);
  }

  @Get('intent/:id')
  @ApiOperation({ summary: 'Estado del intent (para polling del cliente)' })
  getIntent(
    @CurrentUser() user: { userId: string },
    @Param('id') id: string,
  ) {
    return this.binanceService.getIntent(user.userId, id);
  }

  @Post('confirm')
  @ApiOperation({
    summary: 'Confirma el intent con TXID y acredita créditos',
  })
  confirm(
    @CurrentUser() user: { userId: string },
    @Body() dto: ConfirmBinanceIntentDto,
  ) {
    return this.binanceService.confirmWithTxid(
      user.userId,
      dto.intentId,
      dto.txid,
    );
  }
}
