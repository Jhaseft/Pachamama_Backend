import { IsString, IsNotEmpty, IsInt, MinLength, MaxLength, Min, IsNumber, IsOptional, IsBoolean } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreatePackageDto {
    @ApiProperty({ example: 'Normal', description: 'Nombre del paquete' })
    @IsString()
    @IsNotEmpty()
    @MinLength(3)
    @MaxLength(100)
    name: string;

    @ApiProperty({ example: '100', description: 'Valor de créditos que ofrece el paquete' })
    @IsInt()
    @Min(0)
    @IsNotEmpty()
    credits: number;

    @ApiProperty({ example: '20.00', description: 'Precio del paquete' })
    @IsNumber({ maxDecimalPlaces: 2 })
    @Min(0)
    @IsNotEmpty()
    price: number;

    @ApiProperty({ example: true, description: 'Indica si el paquete está activo', required: false })
    @IsBoolean()
    @IsOptional()
    isActive?: boolean;
}