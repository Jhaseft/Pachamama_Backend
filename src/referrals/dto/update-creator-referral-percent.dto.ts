import { Type } from 'class-transformer';
import { IsBoolean, IsNumber, IsOptional, Max, Min } from 'class-validator';

export class UpdateCreatorReferralPercentDto {
  @Type(() => Number)
  @IsNumber()
  @Min(0)
  @Max(100)
  percent: number;

  @IsOptional()
  @IsBoolean()
  isActive?: boolean;
}
