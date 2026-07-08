import { Injectable, NotFoundException, ConflictException } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';
import { CreateSocialLinkDto } from './dto/create-social-link.dto';
import { UpdateSocialLinkDto } from './dto/update-social-link.dto';
import { SocialLinkDto } from './dto/social-link.dto';
import { SocialNetworkDto } from './dto/social-network.dto';

@Injectable()
export class SocialNetworkService {
    constructor(private prisma: PrismaService) { }

    /**
     * Obtener todas las redes sociales disponibles
     */
    async getAllSocialNetworks(userId: string): Promise<SocialNetworkDto[]> {
    const usedNetworks = await this.prisma.anfitrioneProfileSocialLink.findMany({
        where: { anfitrionaProfile: { userId } },
        select: { socialNetworkId: true },
    });

    const usedNetworkIds = usedNetworks.map(link => link.socialNetworkId);

    return this.prisma.socialNetwork.findMany({
        where: {
            id: { notIn: usedNetworkIds },
        },
        orderBy: { name: 'asc' },
    });
}


    /**
     * Obtener una red social por ID
     */
    async getSocialNetworkById(id: string): Promise<SocialNetworkDto> {
        const network = await this.prisma.socialNetwork.findUnique({
            where: { id },
        });

        if (!network) {
            throw new NotFoundException('Red social no encontrada');
        }

        return network;
    }

    /**
     * Agregar un enlace de red social a una anfitriona
     */
    async addSocialLink(
        userId: string,
        dto: CreateSocialLinkDto,
    ): Promise<SocialLinkDto> {
        // Obtener el perfil de anfitriona por userId
        const profile = await this.prisma.anfitrioneProfile.findUnique({
            where: { userId },
        });

        if (!profile) {
            throw new NotFoundException('Perfil de anfitriona no encontrado');
        }

        // Verificar que la red social existe
        const socialNetwork = await this.getSocialNetworkById(dto.socialNetworkId);

        // Verificar que no exista ya un enlace para esta red
        const existingLink = await this.prisma.anfitrioneProfileSocialLink.findUnique({
            where: {
                anfitrionaProfileId_socialNetworkId: {
                    anfitrionaProfileId: profile.id,
                    socialNetworkId: dto.socialNetworkId,
                },
            },
        });

        if (existingLink) {
            throw new ConflictException(
                `Ya existe un enlace para ${socialNetwork.name}`,
            );
        }

        // Crear el enlace
        const link = await this.prisma.anfitrioneProfileSocialLink.create({
            data: {
                anfitrionaProfileId: profile.id,
                socialNetworkId: dto.socialNetworkId,
                url: dto.url,
            },
            include: {
                socialNetwork: true,
            },
        });

        return link as SocialLinkDto;
    }

    /**
     * Actualizar un enlace de red social
     */
    async updateSocialLink(
        linkId: string,
        userId: string,
        dto: UpdateSocialLinkDto,
    ): Promise<SocialLinkDto> {
        // Obtener el perfil de anfitriona por userId
        const profile = await this.prisma.anfitrioneProfile.findUnique({
            where: { userId },
        });

        if (!profile) {
            throw new NotFoundException('Perfil de anfitriona no encontrado');
        }

        // Verificar que el enlace existe y pertenece a la anfitriona
        const link = await this.prisma.anfitrioneProfileSocialLink.findUnique({
            where: { id: linkId },
        });

        if (!link) {
            throw new NotFoundException('Enlace de red social no encontrado');
        }

        if (link.anfitrionaProfileId !== profile.id) {
            throw new NotFoundException('Enlace no pertenece a esta anfitriona');
        }

        // Actualizar el enlace
        const updatedLink = await this.prisma.anfitrioneProfileSocialLink.update({
            where: { id: linkId },
            data: dto,
            include: {
                socialNetwork: true,
            },
        });

        return updatedLink as SocialLinkDto;
    }

    /**
     * Eliminar un enlace de red social
     */
    async deleteSocialLink(
        linkId: string,
        userId: string,
    ): Promise<void> {
        // Obtener el perfil de anfitriona por userId
        const profile = await this.prisma.anfitrioneProfile.findUnique({
            where: { userId },
        });

        if (!profile) {
            throw new NotFoundException('Perfil de anfitriona no encontrado');
        }

        // Verificar que el enlace existe y pertenece a la anfitriona
        const link = await this.prisma.anfitrioneProfileSocialLink.findUnique({
            where: { id: linkId },
        });

        if (!link) {
            throw new NotFoundException('Enlace de red social no encontrado');
        }

        if (link.anfitrionaProfileId !== profile.id) {
            throw new NotFoundException('Enlace no pertenece a esta anfitriona');
        }

        // Eliminar el enlace
        await this.prisma.anfitrioneProfileSocialLink.delete({
            where: { id: linkId },
        });
    }

    /**
     * Obtener todos los enlaces de una anfitriona
     */
    async getAnfitrioneProfileSocialLinks(userId: string): Promise<SocialLinkDto[]> {
        const profile = await this.prisma.anfitrioneProfile.findUnique({
            where: { userId },
        });

        if (!profile) {
            throw new NotFoundException('Perfil de anfitriona no encontrado');
        }

        return this.prisma.anfitrioneProfileSocialLink.findMany({
            where: { anfitrionaProfileId: profile.id },
            include: { socialNetwork: true },
            orderBy: { createdAt: 'desc' },
        }) as Promise<SocialLinkDto[]>;
    }

}
