import { IsString, IsInt, MinLength, MaxLength, Min, IsNumber, IsOptional, IsBoolean } from 'class-validator';
import { ApiProperty, PartialType } from '@nestjs/swagger';
import { CreatePackageDto } from './create-package.dto';

// Usar PartialType ayuda a heredar las validaciones del CreatePackageDto 
// pero marcando automáticamente todos los campos como opcionales.
export class EditPackageDto {
    @ApiProperty({ example: 'Normal Premium', description: 'Nombre del paquete', required: false })
    @IsString()
    @IsOptional()
    @MinLength(3)
    @MaxLength(100)
    name?: string;

    @ApiProperty({ example: 150, description: 'Nuevo valor de créditos', required: false })
    @IsInt()
    @Min(0)
    @IsOptional()
    credits?: number;

    @ApiProperty({ example: 25.50, description: 'Nuevo precio del paquete', required: false })
    @IsNumber({ maxDecimalPlaces: 2 })
    @Min(0)
    @IsOptional()
    price?: number;

    @ApiProperty({ example: false, description: 'Estado de activación del paquete', required: false })
    @IsBoolean()
    @IsOptional()
    isActive?: boolean;
}