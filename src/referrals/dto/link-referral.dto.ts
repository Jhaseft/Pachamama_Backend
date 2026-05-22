import { IsNotEmpty, IsString } from 'class-validator';

export class LinkReferralDto {
  @IsString()
  @IsNotEmpty()
  referralCode: string;
}
