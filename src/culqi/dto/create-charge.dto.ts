import { IsString, IsNotEmpty, IsUUID } from 'class-validator';

export class CreateCulqiChargeDto {
  @IsString()
  @IsNotEmpty()
  culqiToken: string;

  @IsUUID()
  packageId: string;

  @IsUUID()
  clientId: string;
}
