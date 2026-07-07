import { Body, Controller, Get, Param, ParseUUIDPipe, Patch, Post, Put, UseGuards } from '@nestjs/common';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { CurrentUser } from '../auth/decorators/current-user.decorator';
import { SubscriptionsService } from './subscriptions.service';
import { UpsertSubscriptionDto } from './dto/upsert-subscription.dto';

interface JwtUser {
  userId: string;
  role: string;
}

@Controller('subscriptions')
export class SubscriptionsController {
  constructor(private readonly subscriptionsService: SubscriptionsService) {}

  // ─── Anfitriona ──────────────────────────────────────────────────────────

  // GET /subscriptions/my-plan — ver su plan actual
  @UseGuards(JwtAuthGuard)
  @Get('my-plan')
  getMySubscription(@CurrentUser() user: JwtUser) {
    return this.subscriptionsService.getMySubscription(user.userId);
  }

  // PUT /subscriptions/my-plan — crear o editar precio del plan
  @UseGuards(JwtAuthGuard)
  @Put('my-plan')
  upsertMySubscription(
    @CurrentUser() user: JwtUser,
    @Body() dto: UpsertSubscriptionDto,
  ) {
    return this.subscriptionsService.upsertMySubscription(user.userId, dto);
  }

  // PATCH /subscriptions/my-plan/toggle — activar/desactivar su plan
  @UseGuards(JwtAuthGuard)
  @Patch('my-plan/toggle')
  toggleMySubscription(@CurrentUser() user: JwtUser) {
    return this.subscriptionsService.toggleMySubscription(user.userId);
  }

  // ─── Cliente ─────────────────────────────────────────────────────────────

  // GET /subscriptions/my-subscriptions — todas las suscripciones del cliente
  @UseGuards(JwtAuthGuard)
  @Get('my-subscriptions')
  getMySubscriptions(@CurrentUser() user: JwtUser) {
    return this.subscriptionsService.getMySubscriptions(user.userId);
  }

  // GET /subscriptions/public/:anfitrionaId — ver el plan de una anfitriona (sin auth)
  @Get('public/:anfitrionaId')
  getPublicSubscription(@Param('anfitrionaId', ParseUUIDPipe) anfitrionaId: string) {
    return this.subscriptionsService.getPublicSubscription(anfitrionaId);
  }

  // POST /subscriptions/:anfitrionaId/buy — comprar suscripción
  @UseGuards(JwtAuthGuard)
  @Post(':anfitrionaId/buy')
  buySubscription(
    @CurrentUser() user: JwtUser,
    @Param('anfitrionaId') anfitrionaId: string,
  ) {
    return this.subscriptionsService.buySubscription(user.userId, anfitrionaId);
  }

  // GET /subscriptions/:anfitrionaId/status — verificar si tiene suscripción activa
  @UseGuards(JwtAuthGuard)
  @Get(':anfitrionaId/status')
  getSubscriptionStatus(
    @CurrentUser() user: JwtUser,
    @Param('anfitrionaId') anfitrionaId: string,
  ) {
    return this.subscriptionsService.getSubscriptionStatus(user.userId, anfitrionaId);
  }
}
