import { ApiProperty } from '@nestjs/swagger';
import {
    IsEnum,
    IsNotEmpty,
    IsString,
    IsOptional,
    ValidateIf
} from 'class-validator';
import { DepositStatus } from '@prisma/client';

export class UpdateDepositStatusDto {
    @ApiProperty({
        example: DepositStatus.APPROVED,
        description: 'Nuevo estado de la solicitud de depósito',
        enum: [DepositStatus.APPROVED, DepositStatus.REJECTED],
    })
    @IsEnum(DepositStatus, {
        message: 'El estado debe ser APPROVED o REJECTED',
    })
    @IsNotEmpty()
    status: DepositStatus;

    @ApiProperty({
        example: 'El comprobante no es legible o es falso',
        description: 'Motivo del rechazo (obligatorio si el estado es REJECTED)',
        required: false,
    })
    // El decorador ValidateIf hace que este campo sea obligatorio 
    // SOLO cuando el status es REJECTED
    @ValidateIf((o) => o.status === DepositStatus.REJECTED)
    @IsString()
    @IsNotEmpty({ message: 'Debe proporcionar un motivo para el rechazo de la solicitud' })
    rejectionReason?: string;

}