import {
  Injectable,
  BadRequestException,
  NotFoundException,
  InternalServerErrorException,
  Logger,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { Cron, CronExpression } from '@nestjs/schedule';
import { PrismaService } from '../prisma.service';
import {
  Prisma,
  TransactionType,
  BinanceIntentStatus,
} from '@prisma/client';
import * as crypto from 'crypto';

interface BinanceDeposit {
  amount: string;
  coin: string;
  network: string;
  status: number; // 0 pending, 6 credited, 1 success
  address: string;
  addressTag?: string;
  txId: string;
  insertTime: number; // ms
  transferType: number;
  confirmTimes?: string;
}

interface BinanceNetworkConfig {
  network: string;
  label: string;
  wallet: string;
}

const NETWORK_LABEL_DEFAULTS: Record<string, string> = {
  TRX: 'TRC20',
  BSC: 'BEP20',
  ETH: 'ERC20',
  MATIC: 'Polygon',
  ARBITRUM: 'Arbitrum',
  OPTIMISM: 'Optimism',
  AVAX: 'Avalanche',
  BASE: 'Base',
  SOL: 'Solana',
};

@Injectable()
export class BinanceService {
  private readonly logger = new Logger(BinanceService.name);
  private readonly apiKey: string;
  private readonly apiSecret: string;
  private readonly apiBaseUrl: string;
  private readonly coin: string;
  private readonly networks: BinanceNetworkConfig[];
  private readonly defaultNetwork: BinanceNetworkConfig | null;
  private readonly usdRate: number;
  private readonly tolerancePercent: number;
  private readonly intentTtlMinutes: number;
  private readonly historyLookbackMinutes: number;
  private readonly underpayTolerancePercent: number;
  private readonly overpayTolerancePercent: number;
  private readonly manualConfirmLookbackMinutes: number;

  constructor(
    private readonly config: ConfigService,
    private readonly prisma: PrismaService,
  ) {
    this.apiKey = this.config.get<string>('BINANCE_API_KEY') ?? '';
    this.apiSecret = this.config.get<string>('BINANCE_API_SECRET') ?? '';
    this.apiBaseUrl =
      this.config.get<string>('BINANCE_API_BASE_URL') ??
      'https://api.binance.com';
    this.coin = this.config.get<string>('BINANCE_COIN') ?? 'USDT';
    this.networks = this.parseNetworksFromEnv();
    const defaultKey = this.config.get<string>('BINANCE_DEFAULT_NETWORK');
    this.defaultNetwork =
      this.networks.find((n) => n.network === defaultKey) ??
      this.networks[0] ??
      null;
    this.usdRate = Number(
      this.config.get<string>('CREDIT_TO_USD_RATE') ?? '0.25',
    );
    this.tolerancePercent = Number(
      this.config.get<string>('BINANCE_AMOUNT_TOLERANCE_PERCENT') ?? '0.5',
    );
    this.underpayTolerancePercent = Number(
      this.config.get<string>('BINANCE_UNDERPAY_TOLERANCE_PERCENT') ??
        String(this.tolerancePercent),
    );
    this.overpayTolerancePercent = Number(
      this.config.get<string>('BINANCE_OVERPAY_TOLERANCE_PERCENT') ?? '5',
    );
    this.intentTtlMinutes = Number(
      this.config.get<string>('BINANCE_INTENT_TTL_MINUTES') ?? '30',
    );
    this.historyLookbackMinutes = Number(
      this.config.get<string>('BINANCE_HISTORY_LOOKBACK_MINUTES') ?? '90',
    );
    this.manualConfirmLookbackMinutes = Number(
      this.config.get<string>('BINANCE_MANUAL_CONFIRM_LOOKBACK_MINUTES') ??
        '1440', // 24h por defecto
    );

    if (this.networks.length === 0) {
      this.logger.warn(
        'No hay redes Binance configuradas. Define BINANCE_WALLET_<RED> en el .env.',
      );
    } else {
      this.logger.log(
        `Binance redes activas: ${this.networks.map((n) => `${n.network} (${n.label})`).join(', ')}`,
      );
    }
  }

  // Lee process.env y arma la lista de redes:
  //   BINANCE_WALLET_<RED>=<address>           → wallet de esa red
  //   BINANCE_LABEL_<RED>=<etiqueta visible>   → opcional, override del default
  // Backward-compat: si no hay BINANCE_WALLET_<RED>, usa BINANCE_NETWORK + BINANCE_WALLET_ADDRESS.
  private parseNetworksFromEnv(): BinanceNetworkConfig[] {
    const list: BinanceNetworkConfig[] = [];
    const seen = new Set<string>();

    for (const [key, rawValue] of Object.entries(process.env)) {
      const m = /^BINANCE_WALLET_(.+)$/.exec(key);
      if (!m) continue;
      const networkKey = m[1].toUpperCase();
      if (networkKey === 'ADDRESS') continue; // legacy single-wallet
      const wallet = (rawValue ?? '').trim();
      if (!wallet) continue;
      if (seen.has(networkKey)) continue;
      seen.add(networkKey);
      const label =
        process.env[`BINANCE_LABEL_${networkKey}`]?.trim() ||
        NETWORK_LABEL_DEFAULTS[networkKey] ||
        networkKey;
      list.push({ network: networkKey, label, wallet });
    }

    if (list.length === 0) {
      const legacyNetwork = (process.env.BINANCE_NETWORK ?? '').trim().toUpperCase();
      const legacyWallet = (process.env.BINANCE_WALLET_ADDRESS ?? '').trim();
      if (legacyNetwork && legacyWallet) {
        list.push({
          network: legacyNetwork,
          label:
            NETWORK_LABEL_DEFAULTS[legacyNetwork] || legacyNetwork,
          wallet: legacyWallet,
        });
      }
    }

    return list;
  }

  // ─── Public API ───────────────────────────────────────────────────────────

  async createIntent(userId: string, packageId: string) {
    if (!this.defaultNetwork) {
      throw new InternalServerErrorException(
        'No hay redes Binance configuradas. Define BINANCE_WALLET_<RED> en el .env.',
      );
    }

    const pkg = await this.prisma.package.findUnique({
      where: { id: packageId },
    });
    if (!pkg || !pkg.isActive) {
      throw new NotFoundException('Paquete no encontrado o inactivo');
    }

    const user = await this.prisma.user.findUnique({ where: { id: userId } });
    if (!user) throw new NotFoundException('Usuario no encontrado');

    const expectedAmount = new Prisma.Decimal(pkg.credits).mul(this.usdRate);
    const microDelta = new Prisma.Decimal(0);

    // Reutilizar intent PENDING vigente del mismo usuario+paquete si su monto
    // coincide con el actual; si quedaron viejos (cambio de precio o de fórmula),
    // los expiramos para crear uno fresco.
    const existing = await this.prisma.binanceDepositIntent.findFirst({
      where: {
        userId,
        packageId,
        status: BinanceIntentStatus.PENDING,
        expiresAt: { gt: new Date() },
      },
      orderBy: { createdAt: 'desc' },
    });
    if (existing) {
      if (existing.expectedAmount.equals(expectedAmount)) {
        return this.toClientPayload(existing);
      }
      await this.prisma.binanceDepositIntent.updateMany({
        where: {
          userId,
          packageId,
          status: BinanceIntentStatus.PENDING,
        },
        data: { status: BinanceIntentStatus.EXPIRED },
      });
    }

    const expiresAt = new Date(
      Date.now() + this.intentTtlMinutes * 60 * 1000,
    );

    const intent = await this.prisma.binanceDepositIntent.create({
      data: {
        userId,
        packageId,
        packageName: pkg.name,
        creditsToDeliver: pkg.credits,
        network: this.defaultNetwork.network,
        coin: this.coin,
        walletAddress: this.defaultNetwork.wallet,
        expectedAmount,
        microDelta,
        expiresAt,
      },
    });

    return this.toClientPayload(intent);
  }

  async getIntent(userId: string, intentId: string) {
    const intent = await this.prisma.binanceDepositIntent.findFirst({
      where: { id: intentId, userId },
    });
    if (!intent) throw new NotFoundException('Intent no encontrado');
    return this.toClientPayload(intent);
  }

  async confirmWithTxid(userId: string, intentId: string, txid: string) {
    const cleanTxid = txid.trim();
    if (!cleanTxid) {
      throw new BadRequestException('El TXID es obligatorio');
    }

    const intent = await this.prisma.binanceDepositIntent.findFirst({
      where: { id: intentId, userId },
    });
    if (!intent) throw new NotFoundException('Intent no encontrado');

    if (intent.status === BinanceIntentStatus.CONFIRMED) {
      return {
        status: 'CONFIRMED' as const,
        credits: intent.creditsToDeliver,
        message: 'Este pago ya estaba confirmado',
      };
    }

    if (
      intent.status === BinanceIntentStatus.EXPIRED ||
      intent.expiresAt < new Date()
    ) {
      await this.prisma.binanceDepositIntent.update({
        where: { id: intent.id },
        data: { status: BinanceIntentStatus.EXPIRED },
      });
      throw new BadRequestException(
        'Este intent expiró. Crea uno nuevo desde la pantalla de créditos.',
      );
    }

    // TXID ya usado por otro intent (otro usuario o intento anterior)
    const txCollision = await this.prisma.binanceDepositIntent.findUnique({
      where: { txid: cleanTxid },
    });
    if (txCollision && txCollision.id !== intent.id) {
      throw new BadRequestException(
        'Este TXID ya fue usado en otra recarga.',
      );
    }

    // Consultar Binance con ventana ancha — el usuario pegó TXID manualmente,
    // así que el depósito puede ser anterior al intent.
    const deposits = await this.fetchDepositHistory(intent.createdAt, {
      lookbackMs: this.manualConfirmLookbackMinutes * 60 * 1000,
    });
    const userTxid = cleanTxid.toLowerCase();
    const match = deposits.find((d) => {
      if (!d.txId) return false;
      if (d.coin?.toUpperCase() !== intent.coin.toUpperCase()) return false;
      const depTxid = d.txId.toLowerCase().trim();
      // Match exacto
      if (depTxid === userTxid) return true;
      // Off-chain (Binance Pay): la API devuelve "Off-chain transfer 123456789" pero
      // el usuario suele pegar solo el número. Aceptamos substring si tiene >= 10 chars.
      if (userTxid.length >= 10 && depTxid.includes(userTxid)) return true;
      // Caso inverso (raro): el usuario pega texto adicional que envuelve al hash real.
      if (depTxid.length >= 10 && userTxid.includes(depTxid)) return true;
      return false;
    });

    if (!match) {
      throw new BadRequestException(
        'TXID aún no aparece en Binance. Espera unos minutos a que la red confirme y vuelve a intentar.',
      );
    }

    return this.applyDepositMatch(intent.id, match, cleanTxid);
  }

  // ─── Cron de respaldo: matchea por monto+ventana ─────────────────────────

  @Cron(CronExpression.EVERY_MINUTE)
  async pollPendingDeposits() {
    if (!this.apiKey || !this.apiSecret || this.networks.length === 0) return;

    const pendingIntents = await this.prisma.binanceDepositIntent.findMany({
      where: {
        status: BinanceIntentStatus.PENDING,
        expiresAt: { gt: new Date() },
        txid: null,
      },
      orderBy: { createdAt: 'asc' },
    });

    if (pendingIntents.length === 0) {
      // Aprovecha el tick para expirar intents vencidos
      await this.expireOverdueIntents();
      return;
    }

    let deposits: BinanceDeposit[] = [];
    try {
      const earliest = pendingIntents.reduce(
        (acc, i) => (i.createdAt < acc ? i.createdAt : acc),
        pendingIntents[0].createdAt,
      );
      deposits = await this.fetchDepositHistory(earliest);
    } catch (e) {
      this.logger.error('Error consultando Binance deposit history', e as Error);
      return;
    }

    // TXIDs ya usados
    const usedTxids = new Set(
      (
        await this.prisma.binanceDepositIntent.findMany({
          where: { txid: { not: null } },
          select: { txid: true },
        })
      ).map((i) => i.txid!.toLowerCase()),
    );

    for (const dep of deposits) {
      if (!dep.txId) continue;
      if (usedTxids.has(dep.txId.toLowerCase())) continue;
      if (!this.isDepositSuccess(dep)) continue;

      const matches = pendingIntents.filter(
        (i) =>
          i.coin.toUpperCase() === dep.coin?.toUpperCase() &&
          this.amountMatches(i.expectedAmount, dep.amount) &&
          new Date(dep.insertTime).getTime() >=
            i.createdAt.getTime() - 60_000,
      );

      if (matches.length !== 1) continue;

      try {
        await this.applyDepositMatch(matches[0].id, dep, dep.txId);
        usedTxids.add(dep.txId.toLowerCase());
      } catch (e) {
        this.logger.error(
          `Error auto-confirmando intent ${matches[0].id}`,
          e as Error,
        );
      }
    }

    await this.expireOverdueIntents();
  }

  // ─── Internos ─────────────────────────────────────────────────────────────

  private async expireOverdueIntents() {
    await this.prisma.binanceDepositIntent.updateMany({
      where: {
        status: BinanceIntentStatus.PENDING,
        expiresAt: { lt: new Date() },
      },
      data: { status: BinanceIntentStatus.EXPIRED },
    });
  }

  private isDepositSuccess(dep: BinanceDeposit): boolean {
    // Binance: 0 pending, 6 credited (with confirmation count), 1 success
    return dep.status === 1 || dep.status === 6;
  }

  private amountMatches(
    expected: Prisma.Decimal | string | number,
    received: string,
  ): boolean {
    const exp = new Prisma.Decimal(expected);
    const rec = new Prisma.Decimal(received);
    if (exp.isZero()) return false;
    const minAllowed = exp
      .mul(new Prisma.Decimal(100).minus(this.underpayTolerancePercent))
      .div(100);
    const maxAllowed = exp
      .mul(new Prisma.Decimal(100).plus(this.overpayTolerancePercent))
      .div(100);
    return rec.gte(minAllowed) && rec.lte(maxAllowed);
  }

  private toClientPayload(intent: {
    id: string;
    walletAddress: string;
    network: string;
    coin: string;
    expectedAmount: Prisma.Decimal;
    creditsToDeliver: number;
    packageName: string;
    expiresAt: Date;
    status: BinanceIntentStatus;
    txid: string | null;
    failureReason: string | null;
  }) {
    return {
      intentId: intent.id,
      walletAddress: intent.walletAddress,
      network: intent.network,
      coin: intent.coin,
      amount: intent.expectedAmount.toFixed(2),
      credits: intent.creditsToDeliver,
      packageName: intent.packageName,
      expiresAt: intent.expiresAt.toISOString(),
      status: intent.status,
      txid: intent.txid,
      failureReason: intent.failureReason,
      tolerancePercent: this.underpayTolerancePercent,
      networks: this.networks.map((n) => ({
        network: n.network,
        label: n.label,
        wallet: n.wallet,
      })),
      defaultNetwork: this.defaultNetwork?.network ?? null,
    };
  }

  private async applyDepositMatch(
    intentId: string,
    dep: BinanceDeposit,
    txid: string,
  ): Promise<{
    status: 'CONFIRMED';
    credits: number;
    newBalance: string;
    message: string;
  }> {
    const intent = await this.prisma.binanceDepositIntent.findUnique({
      where: { id: intentId },
      include: { user: { include: { wallet: true } } },
    });
    if (!intent) throw new NotFoundException('Intent no encontrado');

    if (intent.status === BinanceIntentStatus.CONFIRMED) {
      const wallet = intent.user?.wallet;
      return {
        status: 'CONFIRMED',
        credits: intent.creditsToDeliver,
        newBalance: wallet ? wallet.balance.toString() : '0',
        message: 'Ya confirmado',
      };
    }

    if (!this.amountMatches(intent.expectedAmount, dep.amount)) {
      await this.prisma.binanceDepositIntent.update({
        where: { id: intent.id },
        data: {
          status: BinanceIntentStatus.REJECTED,
          failureReason: `Monto recibido (${dep.amount}) no coincide con el esperado (${intent.expectedAmount.toFixed(2)})`,
          binanceData: dep as unknown as Prisma.InputJsonValue,
        },
      });
      throw new BadRequestException(
        `Monto recibido (${dep.amount} ${dep.coin}) no coincide con el esperado (${intent.expectedAmount.toFixed(2)} ${intent.coin}). Contacta a soporte.`,
      );
    }

    if (!this.isDepositSuccess(dep)) {
      throw new BadRequestException(
        'El depósito todavía no está confirmado en la red. Espera unos minutos.',
      );
    }

    if (!intent.user?.wallet) {
      throw new InternalServerErrorException(
        'El usuario no tiene wallet asociada',
      );
    }

    try {
      const result = await this.prisma.$transaction(async (tx) => {
        const updatedIntent = await tx.binanceDepositIntent.update({
          where: { id: intent.id },
          data: {
            status: BinanceIntentStatus.CONFIRMED,
            txid,
            confirmedAt: new Date(),
            binanceData: dep as unknown as Prisma.InputJsonValue,
          },
        });

        const updatedWallet = await tx.wallet.update({
          where: { userId: intent.userId },
          data: {
            balance: {
              increment: new Prisma.Decimal(intent.creditsToDeliver),
            },
          },
        });

        await tx.transaction.create({
          data: {
            walletId: updatedWallet.id,
            amount: new Prisma.Decimal(intent.creditsToDeliver),
            type: TransactionType.DEPOSIT,
            description: `Recarga Binance: ${intent.creditsToDeliver} créditos - ${intent.packageName}`,
          },
        });

        return { wallet: updatedWallet, intent: updatedIntent };
      });

      this.logger.log(
        `Binance deposit confirmed: ${intent.creditsToDeliver} credits to user ${intent.userId} (txid=${txid})`,
      );

      return {
        status: 'CONFIRMED',
        credits: intent.creditsToDeliver,
        newBalance: result.wallet.balance.toString(),
        message: '¡Pago confirmado y créditos acreditados!',
      };
    } catch (e: unknown) {
      // Posible carrera con el cron y el confirm manual: si chocó por unique en txid, releer
      if (
        e instanceof Prisma.PrismaClientKnownRequestError &&
        e.code === 'P2002'
      ) {
        const fresh = await this.prisma.binanceDepositIntent.findUnique({
          where: { id: intent.id },
          include: { user: { include: { wallet: true } } },
        });
        if (fresh?.status === BinanceIntentStatus.CONFIRMED) {
          return {
            status: 'CONFIRMED',
            credits: fresh.creditsToDeliver,
            newBalance: fresh.user?.wallet?.balance.toString() ?? '0',
            message: '¡Pago confirmado y créditos acreditados!',
          };
        }
      }
      this.logger.error('Error acreditando depósito Binance', e as Error);
      throw new InternalServerErrorException(
        'Pago verificado pero error al acreditar créditos. Contacta a soporte.',
      );
    }
  }

  // ─── Binance API ──────────────────────────────────────────────────────────

  private async fetchDepositHistory(
    earliest: Date,
    options: { lookbackMs?: number } = {},
  ): Promise<BinanceDeposit[]> {
    if (!this.apiKey || !this.apiSecret) {
      throw new InternalServerErrorException(
        'Binance no está configurada (BINANCE_API_KEY / BINANCE_API_SECRET)',
      );
    }

    const lookbackMs =
      options.lookbackMs ?? this.historyLookbackMinutes * 60 * 1000;
    const startTime = Math.max(
      earliest.getTime() - lookbackMs,
      Date.now() - 90 * 24 * 60 * 60 * 1000, // hard cap 90 días (límite de Binance)
    );

    const params = new URLSearchParams({
      coin: this.coin,
      startTime: String(startTime),
      timestamp: String(Date.now()),
      recvWindow: '10000',
      limit: '1000',
    });

    const signature = crypto
      .createHmac('sha256', this.apiSecret)
      .update(params.toString())
      .digest('hex');
    params.append('signature', signature);

    const url = `${this.apiBaseUrl}/sapi/v1/capital/deposit/hisrec?${params.toString()}`;

    const resp = await fetch(url, {
      method: 'GET',
      headers: { 'X-MBX-APIKEY': this.apiKey },
    });
    const data = await resp.json();

    if (!resp.ok) {
      this.logger.error(`Binance API error: ${JSON.stringify(data)}`);
      throw new InternalServerErrorException(
        `Binance API error: ${data?.msg ?? 'unknown'}`,
      );
    }

    return Array.isArray(data) ? (data as BinanceDeposit[]) : [];
  }
}
