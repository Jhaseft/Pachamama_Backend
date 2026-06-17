import { IsString, IsOptional, IsDateString } from 'class-validator';

export class CompleteGoogleAnfitrioneProfileDto {
  @IsString()
  firstName: string;

  @IsString()
  lastName: string;

  @IsString()
  username: string;

  @IsString()
  cedula: string;

  @IsDateString()
  dateOfBirth: string;

  @IsString()
  @IsOptional()
  referralCode?: string;
}
