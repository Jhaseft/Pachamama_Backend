import { ApiProperty } from '@nestjs/swagger';

export class AnfitrionePublicListItemDto {
  @ApiProperty({ example: '550e8400-e29b-41d4-a716-446655440000' })
  id: string;

  @ApiProperty({ example: 'Maria Lopez' })
  name: string;

  @ApiProperty({ example: 'maria_lopez', nullable: true })
  username: string | null;

  @ApiProperty({
    example: 'https://res.cloudinary.com/demo/image/upload/v1/avatar.jpg',
    nullable: true,
  })
  avatar: string | null;

  @ApiProperty({ example: 'Conversaciones alegres 🌸✨', nullable: true })
  shortDescription: string | null;

  @ApiProperty({ example: 10, nullable: true, description: 'Créditos por conversación' })
  rateCredits: number | null;

  @ApiProperty({
    example: 'https://res.cloudinary.com/demo/image/upload/v1/main.jpg',
    nullable: true,
    description: 'Primera imagen del perfil (para el feed)',
  })
  mainImage: string | null;

  @ApiProperty({
    type: [String],
    example: ['https://res.cloudinary.com/demo/image/upload/v1/img1.jpg'],
    description: 'Todas las imágenes del perfil ordenadas por sortOrder',
  })
  images: string[];

  @ApiProperty({ example: true })
  isOnline: boolean;

  @ApiProperty({ example: 42, description: 'Total de likes recibidos' })
  likesCount: number;
}

export class AnfitrionePublicListResponseDto {
  @ApiProperty({ type: [AnfitrionePublicListItemDto] })
  data: AnfitrionePublicListItemDto[];

  @ApiProperty({ example: 50, description: 'Total de anfitrionas activas' })
  total: number;

  @ApiProperty({ example: 1 })
  page: number;

  @ApiProperty({ example: 10 })
  limit: number;
}
