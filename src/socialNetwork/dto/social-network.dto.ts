import { ApiProperty } from '@nestjs/swagger';

export class SocialNetworkDto {
  @ApiProperty({
    description: 'ID de la red social',
    example: 'b1a2c3d4-e5f6-7g8h-9i0j-k1l2m3n4o5p6',
    format: 'uuid',
  })
  id: string;

  @ApiProperty({
    description: 'Nombre de la red social',
    example: 'Instagram',
  })
  name: string;

  @ApiProperty({
    description: 'URL del icono de la red social',
    example: 'https://example.com/instagram-icon.png',
    nullable: true,
  })
  icon: string | null;

  @ApiProperty({
    description: 'ID público de Cloudinary del icono',
    example: 'pachamama/social-networks/instagram',
    nullable: true,
  })
  iconPublicId: string | null;

  @ApiProperty({
    description: 'Fecha de creación',
    example: '2024-01-15T10:30:00Z',
  })
  createdAt: Date;

  @ApiProperty({
    description: 'Fecha de actualización',
    example: '2024-01-15T10:30:00Z',
  })
  updatedAt: Date;
}
