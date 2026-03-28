import { Controller, Post, Body, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { CulqiService } from './culqi.service';
import { CreateCulqiChargeDto } from './dto/create-charge.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { RolesGuard } from '../auth/guards/roles.guard';
import { Roles } from '../auth/decorators/roles.decorator';
import { CurrentUser } from '../auth/decorators/current-user.decorator';
import { UserRole } from '@prisma/client';
import { IsString, IsNotEmpty, IsUUID } from 'class-validator';

class ChargeMeDto {
  @IsString()
  @IsNotEmpty()
  culqiToken: string;

  @IsUUID()
  packageId: string;
}

@ApiTags('Culqi')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('culqi')
export class CulqiController {
  constructor(private readonly culqiService: CulqiService) {}

  // Admin: charge for any client
  @Post('charge')
  @UseGuards(RolesGuard)
  @Roles(UserRole.ADMIN)
  @ApiOperation({ summary: '[Admin] Cobrar con Culqi y acreditar créditos a un cliente' })
  charge(@Body() dto: CreateCulqiChargeDto) {
    return this.culqiService.charge(dto);
  }

  // Client: charge for themselves
  @Post('charge/me')
  @ApiOperation({ summary: 'El cliente compra créditos con su tarjeta vía Culqi' })
  chargeMe(
    @CurrentUser() user: { userId: string },
    @Body() dto: ChargeMeDto,
  ) {
    return this.culqiService.charge({
      culqiToken: dto.culqiToken,
      packageId: dto.packageId,
      clientId: user.userId,
    });
  }
}
