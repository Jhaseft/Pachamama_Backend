import { Module } from '@nestjs/common';
import { CulqiService } from './culqi.service';
import { CulqiController } from './culqi.controller';

@Module({
  controllers: [CulqiController],
  providers: [CulqiService],
})
export class CulqiModule {}
