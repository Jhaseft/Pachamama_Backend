import { Body, Controller, Get, Post, UseGuards } from '@nestjs/common';
import { UserRole } from '@prisma/client';
import { CurrentUser } from '../auth/decorators/current-user.decorator';
import { Roles } from '../auth/decorators/roles.decorator';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { RolesGuard } from '../auth/guards/roles.guard';
import { LinkReferralDto } from './dto/link-referral.dto';
import { ReferralsService } from './referrals.service';

type JwtUser = {
  userId: string;
  role: UserRole;
};

@UseGuards(JwtAuthGuard)
@Controller('referrals')
export class ReferralsController {
  constructor(private readonly referralsService: ReferralsService) {}

  @Get('me')
  @UseGuards(RolesGuard)
  @Roles(UserRole.ANFITRIONA)
  getMyCreatorReferrals(@CurrentUser() user: JwtUser) {
    return this.referralsService.getMyCreatorReferrals(user.userId);
  }

  @Post('link')
  @UseGuards(RolesGuard)
  @Roles(UserRole.ANFITRIONA)
  linkReferral(@CurrentUser() user: JwtUser, @Body() dto: LinkReferralDto) {
    return this.referralsService.linkReferralCodeToUser(
      user.userId,
      dto.referralCode,
    );
  }
}
