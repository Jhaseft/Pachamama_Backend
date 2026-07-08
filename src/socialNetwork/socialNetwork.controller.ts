import {
    Controller,
    Get,
    Post,
    Put,
    Delete,
    Param,
    Body,
    UseGuards,
    HttpCode,
    HttpStatus,
    ForbiddenException,
    NotFoundException,
} from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { SocialNetworkService } from './socialNetwork.service';
import { CreateSocialLinkDto } from './dto/create-social-link.dto';
import { UpdateSocialLinkDto } from './dto/update-social-link.dto';
import { SocialNetworkDto } from './dto/social-network.dto';
import { SocialLinkDto } from './dto/social-link.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { CurrentUser } from '../auth/decorators/current-user.decorator';
import { PrismaService } from '../../prisma/prisma.service';

interface JwtUser {
    userId: string;
    role: string;
}

@ApiTags('Social Networks')
@Controller('social-networks')
export class SocialNetworkController {
    constructor(
        private readonly socialNetworkService: SocialNetworkService,
        private readonly prisma: PrismaService,
    ) {}

    /**
     * GET /social-networks
     * Obtener todas las redes sociales disponibles (público)
     */
    @Get()
    @UseGuards(JwtAuthGuard)
    @ApiBearerAuth('access-token')
    @ApiOperation({ summary: 'Obtener todas las redes sociales disponibles' })
    async getAllSocialNetworks(@CurrentUser() user: JwtUser): Promise<SocialNetworkDto[]> {
        return this.socialNetworkService.getAllSocialNetworks(user.userId);
    }

    /**
     * GET /social-networks/anfitriona/:anfitrionaProfileId
     * Obtener todos los enlaces de una anfitriona (público)
     */
    @Get('anfitriona/:anfitrionaProfileId')
    @ApiOperation({ summary: 'Obtener todos los enlaces de una anfitriona' })
    async getAnfitrioneProfileSocialLinks(
        @Param('anfitrionaProfileId') anfitrionaProfileId: string,
    ): Promise<SocialLinkDto[]> {
        return this.socialNetworkService.getAnfitrioneProfileSocialLinks(
            anfitrionaProfileId,
        );
    }

    /**
     * POST /social-networks/anfitriona/:anfitrionaProfileId/links
     * Agregar un enlace de red social (protegido)
     */
    @Post('anfitriona/:anfitrionaProfileId/links')
    @UseGuards(JwtAuthGuard)
    @ApiBearerAuth('access-token')
    @HttpCode(HttpStatus.CREATED)
    @ApiOperation({ summary: 'Agregar un enlace de red social' })
    async addSocialLink(
        @Param('anfitrionaProfileId') anfitrionaProfileId: string,
        @Body() dto: CreateSocialLinkDto,
        @CurrentUser() user: JwtUser,
    ): Promise<SocialLinkDto> {
        const profile = await this.prisma.anfitrioneProfile.findUnique({
            where: { userId: anfitrionaProfileId },
        });

        if (!profile) {
            throw new NotFoundException(`Perfil de anfitriona con ID ${anfitrionaProfileId} no encontrado`);
        }

        if (profile.userId !== user.userId) {
            throw new ForbiddenException('No tienes permiso para modificar este perfil');
        }

        return this.socialNetworkService.addSocialLink(user.userId, dto);
    }

    /**
     * PUT /social-networks/anfitriona/:anfitrionaProfileId/links/:linkId
     * Actualizar un enlace de red social (protegido)
     */
    @Put('anfitriona/:anfitrionaProfileId/links/:linkId')
    @UseGuards(JwtAuthGuard)
    @ApiBearerAuth('access-token')
    @HttpCode(HttpStatus.OK)
    @ApiOperation({ summary: 'Actualizar un enlace de red social' })
    async updateSocialLink(
        @Param('anfitrionaProfileId') anfitrionaProfileId: string,
        @Param('linkId') linkId: string,
        @Body() dto: UpdateSocialLinkDto,
        @CurrentUser() user: JwtUser,
    ): Promise<SocialLinkDto> {
        const profile = await this.prisma.anfitrioneProfile.findUnique({
            where: { userId: anfitrionaProfileId },
        });

        if (!profile) {
            throw new NotFoundException('Perfil de anfitriona no encontrado');
        }

        if (profile.userId !== user.userId) {
            throw new ForbiddenException('No tienes permiso para modificar este perfil');
        }

        return this.socialNetworkService.updateSocialLink(
            linkId,
            user.userId,
            dto,
        );
    }

    /**
     * DELETE /social-networks/anfitriona/:anfitrionaProfileId/links/:linkId
     * Eliminar un enlace de red social (protegido)
     */
    @Delete('anfitriona/:anfitrionaProfileId/links/:linkId')
    @UseGuards(JwtAuthGuard)
    @ApiBearerAuth('access-token')
    @HttpCode(HttpStatus.NO_CONTENT)
    @ApiOperation({ summary: 'Eliminar un enlace de red social' })
    async deleteSocialLink(
        @Param('anfitrionaProfileId') anfitrionaProfileId: string,
        @Param('linkId') linkId: string,
        @CurrentUser() user: JwtUser,
    ): Promise<void> {
        const profile = await this.prisma.anfitrioneProfile.findUnique({
            where: { userId: anfitrionaProfileId },
        });

        if (!profile) {
            throw new NotFoundException('Perfil de anfitriona no encontrado');
        }

        if (profile.userId !== user.userId) {
            throw new ForbiddenException('No tienes permiso para modificar este perfil');
        }

        return this.socialNetworkService.deleteSocialLink(linkId, user.userId);
    }

    /**
     * GET /social-networks/:id
     * Obtener una red social por ID (público)
     */
    @Get(':id')
    @ApiOperation({ summary: 'Obtener una red social por ID' })
    async getSocialNetworkById(@Param('id') id: string): Promise<SocialNetworkDto> {
        return this.socialNetworkService.getSocialNetworkById(id);
    }
}
