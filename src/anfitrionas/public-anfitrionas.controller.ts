import { Controller, Get, Param, ParseUUIDPipe } from '@nestjs/common';
import { ApiOperation, ApiParam, ApiResponse, ApiTags } from '@nestjs/swagger';
import { AnfitrioneService } from './anfitrionas.service';
import {
  AnfitrionePublicListResponseDto,
} from './dto/anfitriona-public-list.dto';
import { AnfitrionePublicDetailDto } from './dto/anfitriona-public-detail.dto';

@ApiTags('Anfitrionas - Público')
@Controller('anfitrionas/public')
export class PublicAnfitrioneController {
  constructor(private readonly service: AnfitrioneService) {}

  /**
   * GET /anfitrionas/public
   * Listado público de anfitrionas activas para la pantalla de feed del cliente.
   * No requiere autenticación.
   * TODO (isFavorite): cuando se implemente favoritos, añadir guard JWT opcional
   *   y pasar userId del token para enriquecer la respuesta con isFavorite.
   */
  @Get()
  @ApiOperation({
    summary: 'Listado público de anfitrionas',
    description:
      'Devuelve anfitrionas activas con perfil completo. ' +
      'Listo para reemplazar mock data del frontend (HU1).',
  })
  @ApiResponse({
    status: 200,
    description: 'Lista de anfitrionas',
    type: AnfitrionePublicListResponseDto,
    example: {
      data: [
        {
          id: '550e8400-e29b-41d4-a716-446655440000',
          name: 'Maria Lopez',
          avatar: 'https://res.cloudinary.com/demo/image/upload/v1/avatar.jpg',
          shortDescription: 'Conversaciones alegres 🌸✨',
          rateCredits: 10,
          mainImage: 'https://res.cloudinary.com/demo/image/upload/v1/main.jpg',
          images: ['https://res.cloudinary.com/demo/image/upload/v1/main.jpg'],
          isOnline: true,
        },
      ],
    },
  })
  findAll(): Promise<AnfitrionePublicListResponseDto> {
    return this.service.findAllPublic();
  }

  /**
   * GET /anfitrionas/public/:id
   * Perfil público detallado de una anfitriona (HU2).
   * No requiere autenticación.
   */
  @Get(':id')
  @ApiOperation({
    summary: 'Perfil público de una anfitriona',
    description: 'Devuelve información pública detallada de una anfitriona activa (HU2).',
  })
  @ApiParam({ name: 'id', description: 'UUID del usuario anfitriona' })
  @ApiResponse({
    status: 200,
    description: 'Perfil de la anfitriona',
    type: AnfitrionePublicDetailDto,
    example: {
      id: '550e8400-e29b-41d4-a716-446655440000',
      name: 'Maria Lopez',
      username: 'maria_lopez',
      age: 28,
      bio: 'Conversaciones alegres 🌸✨',
      avatar: 'https://res.cloudinary.com/demo/image/upload/v1/avatar.jpg',
      images: [
        'https://res.cloudinary.com/demo/image/upload/v1/img1.jpg',
        'https://res.cloudinary.com/demo/image/upload/v1/img2.jpg',
      ],
      rateCredits: 10,
      isOnline: true,
    },
  })
  @ApiResponse({ status: 404, description: 'Anfitriona no encontrada' })
  findOne(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<AnfitrionePublicDetailDto> {
    return this.service.findOnePublic(id);
  }
}
