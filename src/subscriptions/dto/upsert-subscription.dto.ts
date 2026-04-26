import { IsNumber, Min } from 'class-validator';

export class UpsertSubscriptionDto {
  @IsNumber()
  @Min(0.01)
  price: number;
}
