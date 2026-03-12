import { Module } from '@nestjs/common';
import { AnfitrioneController } from './anfitrionas.controller';
import { PublicAnfitrioneController } from './public-anfitrionas.controller';
import { AnfitrioneService } from './anfitrionas.service';
import { CloudinaryModule } from '../cloudinary/cloudinary.module';
import { PrismaModule } from '../../prisma/prisma.module';

@Module({
  imports: [PrismaModule, CloudinaryModule],
  // PublicAnfitrioneController MUST be first: its literal /anfitrionas/public
  // route would otherwise be shadowed by AnfitrioneController's dynamic /:id route
  controllers: [PublicAnfitrioneController, AnfitrioneController],
  providers: [AnfitrioneService],
})
export class AnfitrioneModule {}
