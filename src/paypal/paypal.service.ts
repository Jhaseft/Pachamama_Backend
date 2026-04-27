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

interface CachedToken {
  token: string;
  expiresAt: number;
}

@Injectable()
export class PaypalService {
  private readonly logger = new Logger(PaypalService.name);
  private readonly clientId: string;
  private readonly clientSecret: string;
  private readonly apiBaseUrl: string;
  private readonly returnUrl: string;
  private readonly cancelUrl: string;
  private readonly usdRate: number;
  private cachedToken: CachedToken | null = null;

  constructor(
    private readonly config: ConfigService,
    private readonly prisma: PrismaService,
  ) {
    this.clientId = this.config.get<string>('PAYPAL_CLIENT_ID') ?? '';
    this.clientSecret = this.config.get<string>('PAYPAL_CLIENT_SECRET') ?? '';
    const mode = this.config.get<string>('PAYPAL_MODE') ?? 'sandbox';
    this.apiBaseUrl =
      mode === 'live'
        ? 'https://api-m.paypal.com'
        : 'https://api-m.sandbox.paypal.com';
    this.returnUrl =
      this.config.get<string>('PAYPAL_RETURN_URL') ??
      'https://app.pachamama.chat/paypal/return';
    this.cancelUrl =
      this.config.get<string>('PAYPAL_CANCEL_URL') ??
      'https://app.pachamama.chat/paypal/cancel';
    this.usdRate = Number(
      this.config.get<string>('CREDIT_TO_USD_RATE') ?? '0.25',
    );
  }

  private async getAccessToken(): Promise<string> {
    const now = Date.now();
    if (this.cachedToken && this.cachedToken.expiresAt > now + 60_000) {
      return this.cachedToken.token;
    }

    if (!this.clientId || !this.clientSecret) {
      throw new InternalServerErrorException(
        'PayPal no está configurado (PAYPAL_CLIENT_ID / PAYPAL_CLIENT_SECRET)',
      );
    }

    const basic = Buffer.from(
      `${this.clientId}:${this.clientSecret}`,
    ).toString('base64');

    const response = await fetch(`${this.apiBaseUrl}/v1/oauth2/token`, {
      method: 'POST',
      headers: {
        Authorization: `Basic ${basic}`,
        'Content-Type': 'application/x-www-form-urlencoded',
        Accept: 'application/json',
      },
      body: 'grant_type=client_credentials',
    });

    const data = await response.json();
    if (!response.ok || !data.access_token) {
      this.logger.error(`PayPal token error: ${JSON.stringify(data)}`);
      throw new InternalServerErrorException(
        'Error al autenticarse con PayPal',
      );
    }

    const expiresIn = Number(data.expires_in ?? 3600);
    this.cachedToken = {
      token: data.access_token,
      expiresAt: now + expiresIn * 1000,
    };
    return data.access_token;
  }

  async createPayment(
    userId: string,
    packageId: string,
  ): Promise<{ approveUrl: string; orderId: string }> {
    const pkg = await this.prisma.package.findUnique({
      where: { id: packageId },
    });
    if (!pkg || !pkg.isActive) {
      throw new NotFoundException('Paquete no encontrado o inactivo');
    }

    const user = await this.prisma.user.findUnique({ where: { id: userId } });
    if (!user) throw new NotFoundException('Usuario no encontrado');

    const amountUsd = (pkg.credits * this.usdRate).toFixed(2);

    const depositRequest = await this.prisma.depositRequest.create({
      data: {
        userId,
        packageId,
        packageNameAtMoment: pkg.name,
        creditsToDeliver: pkg.credits,
        amount: new Prisma.Decimal(amountUsd),
        status: DepositStatus.PENDING,
        receiptUrl: 'paypal:pending',
      },
    });

    const accessToken = await this.getAccessToken();

    const response = await fetch(`${this.apiBaseUrl}/v2/checkout/orders`, {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${accessToken}`,
        'Content-Type': 'application/json',
        Accept: 'application/json',
      },
      body: JSON.stringify({
        intent: 'CAPTURE',
        purchase_units: [
          {
            reference_id: depositRequest.id,
            custom_id: depositRequest.id,
            description: `${pkg.name} - ${pkg.credits} creditos`,
            amount: {
              currency_code: 'USD',
              value: amountUsd,
            },
          },
        ],
        application_context: {
          brand_name: 'Pachamama',
          user_action: 'PAY_NOW',
          return_url: this.returnUrl,
          cancel_url: this.cancelUrl,
        },
      }),
    });

    const data = await response.json();
    if (!response.ok || !data.id) {
      await this.prisma.depositRequest.delete({
        where: { id: depositRequest.id },
      });
      this.logger.error(`PayPal create order error: ${JSON.stringify(data)}`);
      throw new BadRequestException(
        data.message ?? 'Error al crear la orden de PayPal',
      );
    }

    await this.prisma.depositRequest.update({
      where: { id: depositRequest.id },
      data: { receiptUrl: `paypal:${data.id}` },
    });

    const approveLink = (data.links ?? []).find(
      (l: { rel: string; href: string }) => l.rel === 'approve',
    );
    if (!approveLink?.href) {
      this.logger.error(
        `PayPal order created but no approve link: ${JSON.stringify(data)}`,
      );
      throw new InternalServerErrorException(
        'PayPal no devolvió URL de aprobación',
      );
    }

    return { approveUrl: approveLink.href, orderId: data.id };
  }

  async capturePayment(
    userId: string,
    orderId: string,
  ): Promise<{ credits: number; newBalance: Prisma.Decimal }> {
    const depositRequest = await this.prisma.depositRequest.findFirst({
      where: { userId, receiptUrl: `paypal:${orderId}` },
      include: { package: true, user: { include: { wallet: true } } },
    });

    if (!depositRequest) {
      throw new NotFoundException('Orden no encontrada');
    }

    if (depositRequest.status === DepositStatus.APPROVED) {
      const wallet = depositRequest.user?.wallet;
      return {
        credits: depositRequest.creditsToDeliver,
        newBalance: wallet?.balance ?? new Prisma.Decimal(0),
      };
    }

    const pkg = depositRequest.package;
    const wallet = depositRequest.user?.wallet;
    if (!pkg || !wallet) {
      throw new BadRequestException('Paquete o wallet no disponibles');
    }

    const accessToken = await this.getAccessToken();

    const response = await fetch(
      `${this.apiBaseUrl}/v2/checkout/orders/${orderId}/capture`,
      {
        method: 'POST',
        headers: {
          Authorization: `Bearer ${accessToken}`,
          'Content-Type': 'application/json',
          Accept: 'application/json',
        },
      },
    );

    const data = await response.json();
    if (!response.ok || data.status !== 'COMPLETED') {
      this.logger.error(`PayPal capture error: ${JSON.stringify(data)}`);
      throw new BadRequestException(
        data.message ?? 'El pago no pudo ser capturado',
      );
    }

    try {
      const result = await this.prisma.$transaction(async (tx) => {
        await tx.depositRequest.update({
          where: { id: depositRequest.id },
          data: { status: DepositStatus.APPROVED },
        });

        const updatedWallet = await tx.wallet.update({
          where: { userId },
          data: { balance: { increment: new Prisma.Decimal(pkg.credits) } },
        });

        await tx.transaction.create({
          data: {
            walletId: updatedWallet.id,
            depositRequestId: depositRequest.id,
            amount: new Prisma.Decimal(pkg.credits),
            type: TransactionType.DEPOSIT,
            description: `Recarga PayPal: ${pkg.credits} créditos - ${pkg.name}`,
          },
        });

        return updatedWallet;
      });

      this.logger.log(
        `Wallet credited: ${pkg.credits} credits to user ${userId} via PayPal ${orderId}`,
      );

      return { credits: pkg.credits, newBalance: result.balance };
    } catch (error) {
      this.logger.error('Error crediting wallet after PayPal capture', error);
      throw new InternalServerErrorException(
        'Pago recibido pero error al acreditar créditos',
      );
    }
  }
}
