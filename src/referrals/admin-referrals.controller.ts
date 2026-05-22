import {
  Body,
  Controller,
  Get,
  Param,
  ParseUUIDPipe,
  Patch,
  Post,
  Query,
  UseGuards,
} from '@nestjs/common';
import { CreatorReferralStatus, UserRole } from '@prisma/client';
import { Roles } from '../auth/decorators/roles.decorator';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { RolesGuard } from '../auth/guards/roles.guard';
import { AdminReferralsQueryDto } from './dto/admin-referrals-query.dto';
import { CreateCreatorReferralContractDto } from './dto/create-creator-referral-contract.dto';
import { UpdateCreatorReferralContractDto } from './dto/update-creator-referral-contract.dto';
import { UpdateCreatorReferralPercentDto } from './dto/update-creator-referral-percent.dto';
import { ReferralsService } from './referrals.service';

@UseGuards(JwtAuthGuard, RolesGuard)
@Roles(UserRole.ADMIN)
@Controller('admin/referrals')
export class AdminReferralsController {
  constructor(private readonly referralsService: ReferralsService) {}

  @Get('creators')
  getCreators(@Query() query: AdminReferralsQueryDto) {
    return this.referralsService.getAdminCreatorReferralSettings(query);
  }

  @Get('creator-contracts')
  getCreatorContracts(@Query() query: AdminReferralsQueryDto) {
    return this.referralsService.getAdminCreatorReferralContracts(query);
  }

  @Post('creator-contracts')
  createCreatorContract(@Body() dto: CreateCreatorReferralContractDto) {
    return this.referralsService.createCreatorReferralContract(dto);
  }

  @Patch('creator-contracts/:id')
  updateCreatorContract(
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateCreatorReferralContractDto,
  ) {
    return this.referralsService.updateCreatorReferralContract(id, dto);
  }

  @Patch('creator-contracts/:id/disable')
  disableCreatorContract(@Param('id', ParseUUIDPipe) id: string) {
    return this.referralsService.updateCreatorReferralContract(id, {
      status: CreatorReferralStatus.DISABLED,
    });
  }

  // Legacy endpoint (creator-level setting)
  @Patch('creators/:creatorId/percent')
  updateCreatorPercent(
    @Param('creatorId', ParseUUIDPipe) creatorId: string,
    @Body() dto: UpdateCreatorReferralPercentDto,
  ) {
    return this.referralsService.updateCreatorReferralPercent(
      creatorId,
      dto.percent,
      dto.isActive,
    );
  }
}
