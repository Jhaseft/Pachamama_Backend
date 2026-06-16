import { IsString, IsNotEmpty, IsOptional, MinLength, IsDateString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { Transform } from 'class-transformer';

export class CompleteAnfitrioneRegistrationDto {
    @ApiProperty({ description: 'Token temporal obtenido al verificar OTP' })
    @IsString()
    @IsNotEmpty()
    tempToken: string;

    @ApiProperty({ example: 'Camila' })
    @IsString()
    @IsNotEmpty()
    firstName: string;

    @ApiProperty({ example: 'Sanches' })
    @IsString()
    @IsNotEmpty()
    lastName: string;

    @ApiProperty({ minLength: 6 })
    @IsString()
    @MinLength(6)
    password: string;

    @ApiProperty({ minLength: 6 })
    @IsString()
    @MinLength(6)
    confirmPassword: string;

    @ApiProperty({ example: 'camila_princ' })
    @IsString()
    @IsNotEmpty()
    username: string;

    @ApiProperty({ example: '1995-06-15' })
    @IsDateString()
    @IsNotEmpty()
    dateOfBirth: string;

    @ApiProperty({ example: '12345678' })
    @IsString()
    @IsNotEmpty()
    cedula: string;

    @ApiProperty({ example: 'CAMILA123', required: false })
    @IsOptional()
    @Transform(({ value }) => (typeof value === 'string' ? value.trim() : value))
    @IsString()
    @IsNotEmpty()
    referralCode?: string;
}
