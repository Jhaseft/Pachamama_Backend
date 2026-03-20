import { Module } from '@nestjs/common';
import { DepositsService } from './deposits.service';
import { DepositsController } from './deposits.controller';
import { PrismaModule } from '../../prisma/prisma.module'; // Importante para usar la DB

@Module({
    imports: [PrismaModule],
    controllers: [DepositsController],
    providers: [DepositsService],
})
export class DepositsModule { }