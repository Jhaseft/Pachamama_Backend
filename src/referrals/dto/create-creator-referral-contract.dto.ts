import { Type } from 'class-transformer';
import { IsNumber, IsUUID, Max, Min } from 'class-validator';

export class CreateCreatorReferralContractDto {
  @IsUUID()
  referrerCreatorId: string;

  @IsUUID()
  referredCreatorId: string;

  @Type(() => Number)
  @IsNumber()
  @Min(0.01)
  @Max(100)
  percent: number;
}
