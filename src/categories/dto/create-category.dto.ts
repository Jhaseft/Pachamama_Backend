import {
  IsString,
  IsNotEmpty,
  IsOptional,
  IsBoolean,
  MinLength,
  MaxLength,
} from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateCategoryDto {
  @ApiProperty({ example: 'Gaming', description: 'Nombre de la categoría' })
  @IsString()
  @IsNotEmpty()
  @MinLength(2)
  @MaxLength(60)
  name: string;

  @ApiProperty({
    example: 'gaming',
    description: 'Identificador URL amigable. Si se omite se genera del nombre.',
    required: false,
  })
  @IsString()
  @IsOptional()
  @MaxLength(80)
  slug?: string;

  @ApiProperty({
    example: 'Gamers, streams y contenido épico.',
    description: 'Descripción corta de la categoría',
    required: false,
  })
  @IsString()
  @IsOptional()
  @MaxLength(255)
  description?: string;

  @ApiProperty({
    example: 'https://res.cloudinary.com/.../gaming.png',
    description: 'URL o publicId de la imagen/ícono de la categoría',
    required: false,
  })
  @IsString()
  @IsOptional()
  icon?: string;

  @ApiProperty({
    example: true,
    description: 'Indica si la categoría está activa',
    required: false,
  })
  @IsBoolean()
  @IsOptional()
  isActive?: boolean;
}
