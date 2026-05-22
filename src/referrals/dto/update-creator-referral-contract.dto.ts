import { Type } from 'class-transformer';
import { CreatorReferralStatus } from '@prisma/client';
import { IsEnum, IsNumber, IsOptional, Max, Min } from 'class-validator';

export class UpdateCreatorReferralContractDto {
  @IsOptional()
  @Type(() => Number)
  @IsNumber()
  @Min(0)
  @Max(100)
  percent?: number;

  @IsOptional()
  @IsEnum(CreatorReferralStatus)
  status?: CreatorReferralStatus;
}
