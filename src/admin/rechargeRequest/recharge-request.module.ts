import { Module } from '@nestjs/common';
import { RechargeRequestService } from './recharge-request.service';
import { RechargeRequestController } from './recharge-request.controller';
import { PrismaModule } from '../../../prisma/prisma.module'; // Importante para usar la DB

@Module({
    imports: [PrismaModule],
    controllers: [RechargeRequestController],
    providers: [RechargeRequestService],
})
export class RechargeRequestModule { }