import { Module } from '@nestjs/common';
import { PackageService} from './package.service';
import {PackageController} from './package.controller';
import { PrismaModule } from '../../../prisma/prisma.module'; // Importante para usar la DB

@Module({
  imports: [PrismaModule],
  controllers: [PackageController],
  providers: [PackageService],
})
export class PackageModule {}