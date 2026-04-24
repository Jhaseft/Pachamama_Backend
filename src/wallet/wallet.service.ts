import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { PrismaService } from '../prisma.service';
import { NotificationsService } from '../notifications/notifications.service';

@Injectable()
export class WalletService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly config: ConfigService,
    private readonly notificationsService: NotificationsService,
  ) {}

  async getMyEarnings(userId: string) {
    const wallet = await this.prisma.wallet.upsert({
      where: { userId },
      create: { userId, balance: 0 },
      update: {},
    });

    const now = new Date();
    const startOfToday = new Date(now.getFullYear(), now.getMonth(), now.getDate());
    const startOfWeek = new Date(startOfToday);
    startOfWeek.setDate(startOfToday.getDate() - startOfToday.getDay());

    const [todayResult, weekResult, transactions] = await Promise.all([
      this.prisma.transaction.aggregate({
        where: {
          walletId: wallet.id,
          type: 'EARNING',
          createdAt: { gte: startOfToday },
        },
        _sum: { amount: true },
      }),
      this.prisma.transaction.aggregate({
        where: {
          walletId: wallet.id,
          type: 'EARNING',
          createdAt: { gte: startOfWeek },
        },
        _sum: { amount: true },
      }),
      this.prisma.transaction.findMany({
        where: { walletId: wallet.id, type: 'EARNING' },
        orderBy: { createdAt: 'desc' },
        take: 50,
      }),
    ]);

    const parsedTransactions = transactions.map((tx) => {
      let service = 'Transacción';
      let clientName = '';
      try {
        const meta = JSON.parse(tx.description ?? '{}');
        service = meta.service ?? service;
        clientName = meta.clientName ?? '';
      } catch {
        service = tx.description ?? 'Transacción';
      }
      return {
        id: tx.id,
        service,
        clientName,
        amount: Number(tx.amount),
        createdAt: tx.createdAt,
      };
    });

    return {
      balance: Number(wallet.balance),
      today: Number(todayResult._sum.amount ?? 0),
      thisWeek: Number(weekResult._sum.amount ?? 0),
      total: Number(wallet.balance),
      transactions: parsedTransactions,
    };
  }

  async getBanks() {
    const banks = await this.prisma.banks.findMany({
      orderBy: { name: 'asc' },
    });
    return banks.map((b) => ({
      id: b.id,
      name: b.name,
      logoUrl: b.logo_url,
    }));
  }

  async getBankAccounts(userId: string) {
    const accounts = await this.prisma.bankAccount.findMany({
      where: { userId },
      include: { bank: true },
      orderBy: { createdAt: 'desc' },
    });

    return accounts.map((a) => ({
      id: a.id.toString(),
      type: a.type,
      bankId: a.bankId ?? null,
      bankName: a.bank?.name ?? null,
      bankLogoUrl: a.bank?.logo_url ?? null,
      accountNumber: a.accountNumber ?? null,
      paypalEmail: a.paypalEmail ?? null,
      accountHolderName: a.accountHolderName ?? null,
    }));
  }

  async addBankAccount(
    userId: string,
    dto: {
      type: 'BCP' | 'OTHER_BANK' | 'PAYPAL';
      bankId?: number;
      accountNumber?: string;
      paypalEmail?: string;
      accountHolderName?: string;
    },
  ) {
    const profile = await this.prisma.anfitrioneProfile.findUnique({ where: { userId } });
    if (!profile) throw new NotFoundException('Perfil de anfitriona no encontrado');

    if (dto.type === 'PAYPAL') {
      if (!dto.paypalEmail) throw new BadRequestException('El email de PayPal es requerido');
      const account = await this.prisma.bankAccount.create({
        data: {
          userId,
          type: 'PAYPAL',
          anfitrionaProfileId: profile.id,
          paypalEmail: dto.paypalEmail,
          accountHolderName: dto.accountHolderName,
        },
      });
      return {
        id: account.id.toString(),
        type: account.type,
        bankId: null,
        bankName: null,
        bankLogoUrl: null,
        accountNumber: null,
        paypalEmail: account.paypalEmail,
        accountHolderName: account.accountHolderName,
      };
    }

    // BCP o OTHER_BANK — requieren banco y número de cuenta / CCI
    if (!dto.bankId) throw new BadRequestException('El banco es requerido');
    if (!dto.accountNumber) {
      throw new BadRequestException(
        dto.type === 'BCP' ? 'El número de cuenta es requerido' : 'El CCI es requerido',
      );
    }

    const account = await this.prisma.bankAccount.create({
      data: {
        userId,
        type: dto.type,
        bankId: dto.bankId,
        anfitrionaProfileId: profile.id,
        accountNumber: dto.accountNumber,
        accountHolderName: dto.accountHolderName,
      },
      include: { bank: true },
    });

    return {
      id: account.id.toString(),
      type: account.type,
      bankId: account.bankId,
      bankName: account.bank!.name,
      bankLogoUrl: account.bank!.logo_url,
      accountNumber: account.accountNumber,
      paypalEmail: null,
      accountHolderName: account.accountHolderName,
    };
  }

  async deleteBankAccount(userId: string, accountId: string) {
    const account = await this.prisma.bankAccount.findFirst({
      where: { id: BigInt(accountId), userId },
    });
    if (!account) throw new NotFoundException('Cuenta bancaria no encontrada');
    await this.prisma.bankAccount.delete({ where: { id: BigInt(accountId) } });
    return { message: 'Cuenta eliminada' };
  }

  async createWithdrawalRequest(
    userId: string,
    dto: { credits: number; bankAccountId: string },
  ) {
    if (dto.credits <= 0) {
      throw new BadRequestException('El monto debe ser mayor a 0');
    }

    const minUsd = Number(this.config.get<string>('MIN_WITHDRAWAL_USD') ?? '50');
    const creditsPerUsd = Number(this.config.get<string>('CREDITS_PER_USD') ?? '4');
    const minCredits = minUsd * creditsPerUsd;
    if (dto.credits < minCredits) {
      throw new BadRequestException(
        `El retiro mínimo es de USD ${minUsd} (${minCredits} créditos)`,
      );
    }

    const wallet = await this.prisma.wallet.findUnique({ where: { userId } });
    if (!wallet) {
      throw new NotFoundException('Wallet no encontrada');
    }

    if (Number(wallet.balance) < dto.credits) {
      throw new BadRequestException('Saldo insuficiente');
    }

    const bankAccount = await this.prisma.bankAccount.findFirst({
      where: { id: BigInt(dto.bankAccountId), userId },
    });
    if (!bankAccount) {
      throw new NotFoundException('Cuenta bancaria no encontrada');
    }

    const isPaypal = bankAccount.type === 'PAYPAL';
    const payoutCurrency = isPaypal ? 'USD' : 'PEN';
    const rate = isPaypal
      ? Number(this.config.get<string>('CREDIT_TO_USD_RATE') ?? '0.25')
      : Number(this.config.get<string>('CREDIT_TO_SOLES_RATE') ?? '1');
    const soles = dto.credits * rate; // campo reutilizado: contiene USD para PayPal

    const [, , request] = await this.prisma.$transaction([
      // Descontar créditos de la wallet
      this.prisma.wallet.update({
        where: { id: wallet.id },
        data: { balance: { decrement: dto.credits } },
      }),
      // Registrar transacción de retiro
      this.prisma.transaction.create({
        data: {
          walletId: wallet.id,
          type: 'WITHDRAWAL',
          amount: dto.credits,
          description: JSON.stringify({ reason: 'Solicitud de retiro' }),
        },
      }),
      // Crear la solicitud
      this.prisma.withdrawalRequest.create({
        data: {
          walletId: wallet.id,
          bankAccountId: BigInt(dto.bankAccountId),
          credits: dto.credits,
          soles,
          payoutCurrency,
          status: 'PENDING',
        },
      }),
    ]);

    const created = await this.prisma.withdrawalRequest.findUnique({
      where: { id: (request as any).id },
      include: { bankAccount: { include: { bank: true } } },
    });


    // Notificar a todos los admins
    const [anfitriona, admins] = await Promise.all([
      this.prisma.user.findUnique({
        where: { id: userId },
        select: { firstName: true, lastName: true },
      }),
      this.prisma.user.findMany({
        where: { role: 'ADMIN', isActive: true, fcmToken: { not: null } },
        select: { fcmToken: true },
      }),
    ]);

    const anfitrionaName = [anfitriona?.firstName, anfitriona?.lastName].filter(Boolean).join(' ') || 'Una anfitriona';
    const adminTokens = admins.map(a => a.fcmToken!);

    this.notificationsService.sendMulticastNotification(
      adminTokens,
      '💸 Nueva solicitud de retiro',
      `${anfitrionaName} solicitó un retiro de ${dto.credits} créditos (S/ ${soles.toFixed(2)})`,
      { withdrawalRequestId: (request as any).id, type: 'NEW_WITHDRAWAL_REQUEST' }
    );

    const acc = created!.bankAccount;
    return {
      id: created!.id,
      credits: Number(created!.credits),
      payoutAmount: Number(created!.soles),
      payoutCurrency: created!.payoutCurrency,
      status: created!.status,
      methodType: acc.type,
      bankName: acc.bank?.name ?? null,
      accountNumber: acc.accountNumber ?? null,
      paypalEmail: acc.paypalEmail ?? null,
      createdAt: created!.createdAt,
    };
  }

  async getWithdrawalRequests(userId: string) {
    const wallet = await this.prisma.wallet.findUnique({ where: { userId } });
    if (!wallet) return [];

    const requests = await this.prisma.withdrawalRequest.findMany({
      where: { walletId: wallet.id },
      include: { bankAccount: { include: { bank: true } } },
      orderBy: { createdAt: 'desc' },
    });


    return requests.map((r) => {
      const acc = r.bankAccount;
      return {
        id: r.id,
        credits: Number(r.credits),
        payoutAmount: Number(r.soles),
        payoutCurrency: r.payoutCurrency,
        status: r.status,
        methodType: acc.type,
        bankName: acc.bank?.name ?? null,
        accountNumber: acc.accountNumber ?? null,
        paypalEmail: acc.paypalEmail ?? null,
        rejectionReason: r.rejectionReason ?? null,
        receiptUrl: r.receiptUrl ?? null,
        createdAt: r.createdAt,
      };
    });
  }
}
