import { Injectable, NotFoundException, BadRequestException, InternalServerErrorException } from '@nestjs/common';
import { PrismaService } from '../../../prisma/prisma.service'; // Ajusta la ruta a tu PrismaService
import { DepositStatus, Prisma, UserRole, TransactionType } from '@prisma/client';
import { UpdateDepositStatusDto } from './dto/update-depositsRequest.dto';

@Injectable()
export class RechargeRequestService {
    constructor(
        private prisma: PrismaService) { }

    //OBTENER TODAS LAS SOLICITUDES DE RECARGA (depositRequest)
    async getAllRechargeRequests(search?: string, cursor?: string, limit: number = 10) {
        try {
            //definir las condiciones de búsqueda
            const whereCondition: Prisma.DepositRequestWhereInput = {
                user: {
                    role: UserRole.USER,
                    ...(search && {
                        OR: [
                            { firstName: { contains: search, mode: 'insensitive' } },
                            { lastName: { contains: search, mode: 'insensitive' } },
                            { email: { contains: search, mode: 'insensitive' } },
                            { phoneNumber: { contains: search } },
                        ]
                    })
                }
            }

            // Ejecutamos la consulta con paginación por cursor
            const solicitudesRecharge = await this.prisma.depositRequest.findMany({
                where: whereCondition,
                include: {
                    user: {
                        select: {
                            firstName: true,
                            lastName: true,
                            email: true,
                            phoneNumber: true
                        }
                    },
                    package: {
                        select: {
                            name: true,
                            price: true
                        }
                    },
                    paymentMethod: {
                        select: {
                            type: true
                        }
                    }
                },
                orderBy: { id: 'desc' },
                take: limit + 1, // para saber si hay más datos
                ...(cursor && {
                    skip: 1,
                    cursor: { id: cursor }
                })

            });

            // Lógica para el siguiente cursor (Cargado automático)
            let nextCursor: string | null = null;

            if (solicitudesRecharge.length > limit) {
                solicitudesRecharge.pop(); // quitamos el extra
                nextCursor = solicitudesRecharge[solicitudesRecharge.length - 1].id; // último que enviamos
            }

            return {
                requests: solicitudesRecharge,
                nextCursor
            };

        } catch (error) {
            console.error('Error en getAllRechargeRequests:', error);
            throw new InternalServerErrorException('Error al obtener las solicitudes de recarga');
        }
    }

    /**
     * ACTUALIZAR ESTADO DE SOLICITUD (APROBAR O RECHAZAR)
     * Este método maneja la lógica contable y de billetera
     */
    async updateDepositStatus(id: string, updateDto: UpdateDepositStatusDto) {
        const { status, rejectionReason } = updateDto;

        // 1. Verificar que la solicitud existe y está pendiente
        const depositRequest = await this.prisma.depositRequest.findUnique({
            where: { id },
            include: { package: true } // Necesitamos los créditos del paquete
        });

        if (!depositRequest) {
            throw new NotFoundException('La solicitud de recarga no existe.');
        }

        if (!depositRequest.package) {
            throw new InternalServerErrorException('El paquete asociado a la solicitud no existe.');
        }

        if (depositRequest.status !== DepositStatus.PENDING) {
            throw new BadRequestException(`Esta solicitud ya fue procesada y tiene estado: ${depositRequest.status}`);
        }

        // --- CASO: RECHAZO ---
        if (status === DepositStatus.REJECTED) {
            return await this.prisma.depositRequest.update({
                where: { id },
                data: {
                    status: DepositStatus.REJECTED,
                    rejectionReason: rejectionReason,
                }
            });
        }

        // --- CASO: APROBACIÓN (Transacción Atómica) ---
        const creditsToSum = depositRequest.package.credits || 0;

        try {
            return await this.prisma.$transaction(async (tx) => {
                // Actualizar el estado de la solicitud
                const updatedRequest = await tx.depositRequest.update({
                    where: { id },
                    data: { 
                        status: DepositStatus.APPROVED,
                        rejectionReason: null // Limpiar campo de rechazo 
                    }
                });

                // Incrementar el saldo en la billetera (Wallet)
                // Usamos increment para evitar condiciones de carrera (Race Conditions)
                const updatedWallet = await tx.wallet.update({
                    where: { userId: depositRequest.userId },
                    data: {
                        balance: {
                            increment: new Prisma.Decimal(creditsToSum)
                        }
                    }
                });

                // Crear el historial contable (Transaction)
                await tx.transaction.create({
                    data: {
                        walletId: updatedWallet.id,
                        depositRequestId: depositRequest.id,
                        amount: new Prisma.Decimal(creditsToSum),
                        type: TransactionType.DEPOSIT,
                        description: `Recarga aprobada: ${creditsToSum} créditos - Paquete ${depositRequest.package?.name}`
                    }
                });

                return {
                    message: 'Depósito aprobado con éxito. Saldo actualizado.',
                    request: updatedRequest
                };
            });
        } catch (error) {
            console.error('Error en transacción de aprobación:', error);
            throw new InternalServerErrorException('No se pudo procesar la aprobación. Intente de nuevo.');
        }
    }




}
