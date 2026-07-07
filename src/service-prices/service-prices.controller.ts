import { Body, Controller, Get, Param, ParseUUIDPipe, Put, UseGuards } from '@nestjs/common';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { CurrentUser } from '../auth/decorators/current-user.decorator';
import { ServicePricesService } from './service-prices.service';
import { UpsertServicePriceDto } from './dto/upsert-service-price.dto';

interface JwtUser {
  userId: string;
  role: string;
}

@Controller('service-prices')
export class ServicePricesController {
  constructor(private readonly servicePricesService: ServicePricesService) {}

  // GET /service-prices/public/:userId — precios públicos de cualquier anfitriona (sin auth)
  @Get('public/:userId')
  getPublicPrices(@Param('userId', ParseUUIDPipe) userId: string) {
    return this.servicePricesService.getPublicPrices(userId);
  }

  // GET /service-prices — anfitriona consulta sus precios
  @UseGuards(JwtAuthGuard)
  @Get()
  getMyPrices(@CurrentUser() user: JwtUser) {
    return this.servicePricesService.getMyPrices(user.userId);
  }

  // PUT /service-prices — anfitriona crea o actualiza un precio
  @UseGuards(JwtAuthGuard)
  @Put()
  upsertPrice(@CurrentUser() user: JwtUser, @Body() dto: UpsertServicePriceDto) {
    return this.servicePricesService.upsertPrice(user.userId, dto);
  }
}
