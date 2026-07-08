import { Module } from '@nestjs/common';
import { SocialNetworkService} from './socialNetwork.service';
import { SocialNetworkController } from './socialNetwork.controller';
import { PrismaModule } from '../prisma.module';

@Module({
    imports: [PrismaModule],
    controllers: [SocialNetworkController],
    providers: [SocialNetworkService],
    exports: [SocialNetworkService],
})
export class SocialNetworkModule { }
