import {
  Injectable,
  BadRequestException,
  NotFoundException,
  InternalServerErrorException,
  Logger,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { PrismaService } from '../prisma.service';
import { Prisma, TransactionType, DepositStatus } from '@prisma/client';
import { CreateCulqiChargeDto } from './dto/create-charge.dto';

@Injectable()
export class CulqiService {
  private readonly logger = new Logger(CulqiService.name);
  private readonly secretKey: string;

  constructor(
    private readonly configService: ConfigService,
    private readonly prisma: PrismaService,
  ) {
    this.secretKey = this.configService.get<string>('CULQI_SECRET_KEY') ?? '';
  }

  async charge(dto: CreateCulqiChargeDto) {
    const { culqiToken, packageId, clientId } = dto;

    // 1. Validate package
    const pkg = await this.prisma.package.findUnique({ where: { id: packageId } });
    if (!pkg || !pkg.isActive) {
      throw new NotFoundException('Paquete no encontrado o inactivo');
    }

    // 2. Validate client + wallet
    const client = await this.prisma.user.findUnique({
      where: { id: clientId },
      include: { wallet: true },
    });
    if (!client) throw new NotFoundException('Cliente no encontrado');
    if (!client.wallet) throw new BadRequestException('El cliente no tiene billetera');

    // 3. Charge via Culqi API
    const amountInCents = Math.round(Number(pkg.price) * 100);
    this.logger.log(`Charging via Culqi: ${amountInCents} cents for package "${pkg.name}"`);

    const culqiResponse = await this.callCulqiAPI({
      sourceId: culqiToken,
      amount: amountInCents,
      email: client.email ?? 'cliente@pachamama.com',
      description: `Recarga: ${pkg.name} - ${pkg.credits} créditos`,
    });

    this.logger.debug(`Culqi response: ${JSON.stringify(culqiResponse)}`);

    if (culqiResponse.object !== 'charge' || culqiResponse.outcome?.type !== 'venta_exitosa') {
      const msg =
        culqiResponse.merchant_message ??
        culqiResponse.user_message ??
        'El pago fue rechazado';
      this.logger.warn(`Culqi charge rejected: ${msg}`);
      throw new BadRequestException(`Pago rechazado: ${msg}`);
    }

    // 4. Atomic wallet credit
    try {
      const result = await this.prisma.$transaction(async (tx) => {
        const depositRequest = await tx.depositRequest.create({
          data: {
            userId: clientId,
            packageId,
            packageNameAtMoment: pkg.name,
            creditsToDeliver: pkg.credits,
            amount: pkg.price,
            status: DepositStatus.APPROVED,
            receiptUrl: `culqi_charge:${culqiResponse.id}`,
          },
        });

        const updatedWallet = await tx.wallet.update({
          where: { userId: clientId },
          data: { balance: { increment: new Prisma.Decimal(pkg.credits) } },
        });

        await tx.transaction.create({
          data: {
            walletId: updatedWallet.id,
            depositRequestId: depositRequest.id,
            amount: new Prisma.Decimal(pkg.credits),
            type: TransactionType.DEPOSIT,
            description: `Recarga Culqi: ${pkg.credits} créditos - ${pkg.name}`,
          },
        });

        return { updatedWallet };
      });

      this.logger.log(`Wallet credited: ${pkg.credits} credits to client ${clientId}`);

      return {
        message: 'Recarga exitosa',
        credits: pkg.credits,
        newBalance: result.updatedWallet.balance,
        chargeId: culqiResponse.id,
      };
    } catch (error) {
      this.logger.error('Error crediting wallet after successful Culqi charge', error);
      throw new InternalServerErrorException(
        'El pago fue procesado pero no se pudo acreditar la wallet. Contacte al soporte con el ID: ' +
          culqiResponse.id,
      );
    }
  }

  private async callCulqiAPI(params: {
    sourceId: string;
    amount: number;
    email: string;
    description: string;
  }): Promise<any> {
    const response = await fetch('https://api.culqi.com/v2/charges', {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${this.secretKey}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        amount: params.amount,
        currency_code: 'PEN',
        email: params.email,
        source_id: params.sourceId,
        description: params.description,
        capture: true,
      }),
    });

    if (!response.ok && response.status >= 500) {
      throw new InternalServerErrorException('Error al comunicarse con Culqi');
    }

    return response.json();
  }
}
