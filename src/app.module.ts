import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { PrismaModule } from './prisma.module';

import { PackageModule } from './admin/package/package.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: '.env',
    }),
    PrismaModule,
    PackageModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
