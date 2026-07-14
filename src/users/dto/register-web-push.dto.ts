import { IsNotEmpty, IsOptional, IsString } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class RegisterWebPushDto {
    @ApiProperty({ description: 'Token FCM generado por el navegador' })
    @IsString()
    @IsNotEmpty()
    token: string;

    @ApiPropertyOptional({ description: 'Navegador/dispositivo, para identificar la credencial' })
    @IsOptional()
    @IsString()
    userAgent?: string;
}
