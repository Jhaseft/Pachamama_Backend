import {
  BadRequestException,
  Injectable,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import {
  CreatorReferralRewardStatus,
  CreatorReferralStatus,
  Prisma,
  TransactionType,
  UserRole,
} from '@prisma/client';
import { PrismaService } from '../prisma.service';
import { buildReferralCode } from './utils/referral-code.util';

type EarningRewardInput = {
  referredCreatorId: string;
  sourceEarningTransactionId: string;
  sourceEarningAmount: number;
  sourceType?: TransactionType;
  purchaseCreatorId?: string | null;
};

@Injectable()
export class ReferralsService {
  private readonly logger = new Logger(ReferralsService.name);

  constructor(private readonly prisma: PrismaService) {}

  private normalizeReferralCode(code: string): string {
    return code.trim().toUpperCase();
  }

  private roundToTwo(value: number): Prisma.Decimal {
    const rounded = Math.round(value * 100) / 100;
    return new Prisma.Decimal(rounded.toFixed(2));
  }

  async validateCreatorReferralCode(referralCode?: string | null) {
    if (!referralCode) return null;

    const normalizedCode = this.normalizeReferralCode(referralCode);
    if (!normalizedCode) {
      throw new BadRequestException('El codigo de referido no puede estar vacio.');
    }

    const referrer = await this.prisma.user.findUnique({
      where: { referralCode: normalizedCode },
      select: { id: true, role: true, referralCode: true },
    });

    if (!referrer) {
      throw new BadRequestException('Codigo de referido invalido.');
    }

    if (referrer.role !== UserRole.ANFITRIONA) {
      throw new BadRequestException(
        'El codigo de referido no pertenece a una creadora autorizada.',
      );
    }

    return referrer;
  }

  async ensureCreatorReferralCode(creatorId: string): Promise<string> {
    const creator = await this.prisma.user.findUnique({
      where: { id: creatorId },
      select: { id: true, role: true, referralCode: true, firstName: true },
    });

    if (!creator) {
      throw new NotFoundException('Creador de contenido no encontrado.');
    }

    if (creator.role !== UserRole.ANFITRIONA) {
      throw new BadRequestException(
        'Solo los creadores de contenido pueden tener código de referido.',
      );
    }

    if (creator.referralCode) {
      return creator.referralCode;
    }

    for (let attempt = 0; attempt < 20; attempt += 1) {
      const candidate = buildReferralCode(creator.firstName ?? undefined);
      try {
        const updated = await this.prisma.user.update({
          where: { id: creator.id },
          data: { referralCode: candidate },
          select: { referralCode: true },
        });
        if (updated.referralCode) {
          return updated.referralCode;
        }
      } catch (error) {
        if (
          error instanceof Prisma.PrismaClientKnownRequestError &&
          error.code === 'P2002'
        ) {
          continue;
        }
        throw error;
      }
    }

    throw new BadRequestException(
      'No se pudo generar un código de referido único. Intenta nuevamente.',
    );
  }

  async createPendingCreatorReferralFromCode(params: {
    referredCreatorId: string;
    referralCode?: string | null;
  }) {
    const { referredCreatorId, referralCode } = params;
    if (!referralCode) return null;

    const normalizedCode = this.normalizeReferralCode(referralCode);
    if (!normalizedCode) {
      throw new BadRequestException('El codigo de referido no puede estar vacio.');
    }

    const [referredCreator, referrer] = await Promise.all([
      this.prisma.user.findUnique({
        where: { id: referredCreatorId },
        select: { id: true, role: true },
      }),
      this.validateCreatorReferralCode(normalizedCode),
    ]);

    if (!referredCreator) {
      throw new NotFoundException('Creadora referida no encontrada.');
    }

    if (referredCreator.role !== UserRole.ANFITRIONA) {
      throw new BadRequestException(
        'Solo las creadoras pueden vincular contratos de referido creator-to-creator.',
      );
    }

    if (!referrer) {
      throw new BadRequestException('Codigo de referido invalido.');
    }

    if (referrer.id === referredCreatorId) {
      throw new BadRequestException('No se permite autorreferido.');
    }

    const pendingStatus = 'PENDING' as CreatorReferralStatus;

    const existingReferral = await this.prisma.creatorReferral.findFirst({
      where: {
        OR: [
          { referredCreatorId },
          { referredUserId: referredCreatorId },
        ],
      },
      select: { id: true, status: true, referrerCreatorId: true },
    });

    if (existingReferral) {
      if (existingReferral.referrerCreatorId === referrer.id) {
        return this.prisma.creatorReferral.findUnique({
          where: { id: existingReferral.id },
        });
      }

      if (
        existingReferral.status === CreatorReferralStatus.ACTIVE ||
        existingReferral.status === pendingStatus
      ) {
        throw new BadRequestException(
          'La creadora referida ya tiene un contrato activo o pendiente.',
        );
      }

      throw new BadRequestException(
        'La creadora referida ya tiene un contrato de referido registrado.',
      );
    }

    try {
      return await this.prisma.creatorReferral.create({
        data: {
          referrerCreatorId: referrer.id,
          referredUserId: referredCreatorId,
          referredCreatorId,
          referralCodeUsed: referrer.referralCode ?? normalizedCode,
          percent: this.roundToTwo(0),
          status: pendingStatus,
        },
      });
    } catch (error) {
      if (
        error instanceof Prisma.PrismaClientKnownRequestError &&
        error.code === 'P2002'
      ) {
        const referral = await this.prisma.creatorReferral.findFirst({
          where: {
            OR: [
              { referredCreatorId },
              { referredUserId: referredCreatorId },
            ],
          },
        });
        if (referral) return referral;
      }
      throw error;
    }
  }

  async linkReferralCodeToUser(referredUserId: string, referralCode: string) {
    return this.createPendingCreatorReferralFromCode({
      referredCreatorId: referredUserId,
      referralCode,
    });
  }

  async tryLinkReferralCodeToUser(
    referredUserId: string,
    referralCode?: string | null,
  ) {
    if (!referralCode) return null;
    return this.linkReferralCodeToUser(referredUserId, referralCode);
  }

  async getMyCreatorReferrals(creatorId: string) {
    const referralCode = await this.ensureCreatorReferralCode(creatorId);

    const [setting, referrals, totals, rewardByReferral, rewardEvents] = await Promise.all([
      this.prisma.creatorReferralSetting.findUnique({
        where: { creatorId },
      }),
      this.prisma.creatorReferral.findMany({
        where: { referrerCreatorId: creatorId, referredCreatorId: { not: null } },
        orderBy: { createdAt: 'desc' },
        include: {
          referredCreator: {
            select: {
              id: true,
              firstName: true,
              lastName: true,
              email: true,
            },
          },
        },
      }),
      this.prisma.creatorReferralRewardEvent.aggregate({
        where: {
          referrerCreatorId: creatorId,
          status: CreatorReferralRewardStatus.PAID,
        },
        _sum: { rewardAmount: true },
      }),
      this.prisma.creatorReferralRewardEvent.groupBy({
        by: ['referralId'],
        where: {
          referrerCreatorId: creatorId,
          status: CreatorReferralRewardStatus.PAID,
        },
        _sum: { rewardAmount: true, sourceAmount: true },
        _count: { _all: true },
      }),
      this.prisma.creatorReferralRewardEvent.findMany({
        where: {
          referrerCreatorId: creatorId,
          status: CreatorReferralRewardStatus.PAID,
        },
        orderBy: { createdAt: 'desc' },
        select: {
          referralId: true,
          sourceTransactionId: true,
          rewardTransactionId: true,
          sourceAmount: true,
          percent: true,
          rewardAmount: true,
          createdAt: true,
        },
      }),
    ]);

    const rewardMap = new Map(
      rewardByReferral.map((row) => [
        row.referralId,
        {
          totalGenerated: Number(row._sum.sourceAmount ?? 0),
          totalRewardAmount: Number(row._sum.rewardAmount ?? 0),
          rewardEventsCount: row._count._all,
        },
      ]),
    );

    return {
      referralCode,
      percent: Number(setting?.percent ?? 0),
      isActive: setting?.isActive ?? false,
      totalReferrals: referrals.length,
      totalRewardAmount: Number(totals._sum.rewardAmount ?? 0),
      referrals: referrals.map((referral) => {
        const details = rewardMap.get(referral.id);
        const creator = referral.referredCreator;
        const fullName = [
          creator?.firstName,
          creator?.lastName,
        ]
          .filter(Boolean)
          .join(' ');

        return {
          id: referral.id,
          referralId: referral.id,
          referredCreatorId: referral.referredCreatorId,
          referredUserId: referral.referredUserId,
          percent: Number(referral.percent ?? 0),
          status: referral.status,
          referredCreator: creator
            ? {
                id: creator.id,
                name: fullName || null,
                email: creator.email ?? null,
              }
            : null,
          name: fullName || null,
          email: creator?.email ?? null,
          createdAt: referral.createdAt,
          qualifiedAt: referral.qualifiedAt,
          totalGenerated: details?.totalGenerated ?? 0,
          totalRewardAmount: details?.totalRewardAmount ?? 0,
          rewardEventsCount: details?.rewardEventsCount ?? 0,
          rewardEvents: rewardEvents
            .filter((event) => event.referralId === referral.id)
            .map((event) => ({
              sourceEarningTransactionId: event.sourceTransactionId,
              rewardTransactionId: event.rewardTransactionId,
              sourceEarningAmount: Number(event.sourceAmount),
              percent: Number(event.percent),
              rewardAmount: Number(event.rewardAmount),
              createdAt: event.createdAt,
            })),
        };
      }),
    };
  }

  async updateCreatorReferralPercent(
    creatorId: string,
    percent: number,
    isActive?: boolean,
  ) {
    const creator = await this.prisma.user.findUnique({
      where: { id: creatorId },
      select: { id: true, role: true },
    });

    if (!creator) {
      throw new NotFoundException('Creador de contenido no encontrado.');
    }

    if (creator.role !== UserRole.ANFITRIONA) {
      throw new BadRequestException(
        'El usuario seleccionado no es creador de contenido.',
      );
    }

    if (percent <= 0 || percent > 100) {
      throw new BadRequestException(
        'El porcentaje de referido debe estar entre 0 (exclusivo) y 100.',
      );
    }

    return this.prisma.creatorReferralSetting.upsert({
      where: { creatorId },
      create: {
        creatorId,
        percent: this.roundToTwo(percent),
        isActive: isActive ?? true,
      },
      update: {
        percent: this.roundToTwo(percent),
        ...(isActive !== undefined ? { isActive } : {}),
      },
    });
  }

  async getAdminCreatorReferralSettings(params: {
    search?: string;
    page?: number;
    limit?: number;
  }) {
    const page = params.page && params.page > 0 ? params.page : 1;
    const limit = params.limit && params.limit > 0 ? Math.min(params.limit, 100) : 20;
    const search = params.search?.trim();

    const where: Prisma.UserWhereInput = {
      role: UserRole.ANFITRIONA,
      ...(search
        ? {
            OR: [
              { firstName: { contains: search, mode: 'insensitive' } },
              { lastName: { contains: search, mode: 'insensitive' } },
              { email: { contains: search, mode: 'insensitive' } },
              { referralCode: { contains: search, mode: 'insensitive' } },
            ],
          }
        : {}),
    };

    const [total, creators] = await Promise.all([
      this.prisma.user.count({ where }),
      this.prisma.user.findMany({
        where,
        orderBy: { createdAt: 'desc' },
        skip: (page - 1) * limit,
        take: limit,
        select: {
          id: true,
          firstName: true,
          lastName: true,
          email: true,
          referralCode: true,
          creatorReferralSetting: {
            select: {
              percent: true,
              isActive: true,
            },
          },
        },
      }),
    ]);

    const creatorIds = creators.map((creator) => creator.id);

    const [referralCounts, rewardSums] = await Promise.all([
      this.prisma.creatorReferral.groupBy({
        by: ['referrerCreatorId'],
        where: { referrerCreatorId: { in: creatorIds } },
        _count: { _all: true },
      }),
      this.prisma.creatorReferralRewardEvent.groupBy({
        by: ['referrerCreatorId'],
        where: {
          referrerCreatorId: { in: creatorIds },
          status: CreatorReferralRewardStatus.PAID,
        },
        _sum: { rewardAmount: true },
      }),
    ]);

    const countMap = new Map(
      referralCounts.map((row) => [row.referrerCreatorId, row._count._all]),
    );
    const rewardMap = new Map(
      rewardSums.map((row) => [
        row.referrerCreatorId,
        Number(row._sum.rewardAmount ?? 0),
      ]),
    );

    return {
      total,
      page,
      limit,
      data: creators.map((creator) => ({
        id: creator.id,
        name: [creator.firstName, creator.lastName].filter(Boolean).join(' ') || null,
        email: creator.email,
        referralCode: creator.referralCode,
        percent: Number(creator.creatorReferralSetting?.percent ?? 0),
        isActive: creator.creatorReferralSetting?.isActive ?? false,
        totalReferrals: countMap.get(creator.id) ?? 0,
        totalGenerated: rewardMap.get(creator.id) ?? 0,
      })),
    };
  }

  async getAdminCreatorReferralContracts(params: {
    search?: string;
    page?: number;
    limit?: number;
  }) {
    const page = params.page && params.page > 0 ? params.page : 1;
    const limit = params.limit && params.limit > 0 ? Math.min(params.limit, 100) : 20;
    const search = params.search?.trim();

    const where: Prisma.CreatorReferralWhereInput = {
      referredCreatorId: { not: null },
      ...(search
        ? {
            OR: [
              {
                referrerCreator: {
                  firstName: { contains: search, mode: 'insensitive' },
                },
              },
              {
                referrerCreator: {
                  lastName: { contains: search, mode: 'insensitive' },
                },
              },
              {
                referrerCreator: {
                  email: { contains: search, mode: 'insensitive' },
                },
              },
              {
                referredCreator: {
                  firstName: { contains: search, mode: 'insensitive' },
                },
              },
              {
                referredCreator: {
                  lastName: { contains: search, mode: 'insensitive' },
                },
              },
              {
                referredCreator: {
                  email: { contains: search, mode: 'insensitive' },
                },
              },
            ],
          }
        : {}),
    };

    const [total, contracts] = await Promise.all([
      this.prisma.creatorReferral.count({ where }),
      this.prisma.creatorReferral.findMany({
        where,
        orderBy: { createdAt: 'desc' },
        skip: (page - 1) * limit,
        take: limit,
        include: {
          referrerCreator: {
            select: {
              id: true,
              firstName: true,
              lastName: true,
              email: true,
              referralCode: true,
            },
          },
          referredCreator: {
            select: { id: true, firstName: true, lastName: true, email: true },
          },
        },
      }),
    ]);

    const contractIds = contracts.map((contract) => contract.id);
    const aggregates = await this.prisma.creatorReferralRewardEvent.groupBy({
      by: ['referralId'],
      where: {
        referralId: { in: contractIds },
        status: CreatorReferralRewardStatus.PAID,
      },
      _sum: { sourceAmount: true, rewardAmount: true },
      _count: { _all: true },
    });

    const aggregateMap = new Map(
      aggregates.map((row) => [
        row.referralId,
        {
          totalGeneratedByReferredCreator: Number(row._sum.sourceAmount ?? 0),
          totalCommissionPaid: Number(row._sum.rewardAmount ?? 0),
          rewardEventsCount: row._count._all,
        },
      ]),
    );

    return {
      total,
      page,
      limit,
      data: contracts.map((contract) => {
        const referrerName =
          [contract.referrerCreator.firstName, contract.referrerCreator.lastName]
            .filter(Boolean)
            .join(' ') || null;
        const referredName =
          [contract.referredCreator?.firstName, contract.referredCreator?.lastName]
            .filter(Boolean)
            .join(' ') || null;
        const stats = aggregateMap.get(contract.id);

        return {
          id: contract.id,
          referrerCreatorId: contract.referrerCreatorId,
          referredCreatorId: contract.referredCreatorId,
          referrerCreator: {
            id: contract.referrerCreator.id,
            name: referrerName,
            email: contract.referrerCreator.email,
            referralCode: contract.referrerCreator.referralCode ?? null,
          },
          referredCreator: {
            id: contract.referredCreator?.id ?? contract.referredCreatorId,
            name: referredName,
            email: contract.referredCreator?.email ?? null,
          },
          percent: Number(contract.percent ?? 0),
          status: contract.status,
          totalGenerated: stats?.totalGeneratedByReferredCreator ?? 0,
          totalRewardAmount: stats?.totalCommissionPaid ?? 0,
          totalGeneratedByReferredCreator:
            stats?.totalGeneratedByReferredCreator ?? 0,
          totalCommissionPaid: stats?.totalCommissionPaid ?? 0,
          rewardEventsCount: stats?.rewardEventsCount ?? 0,
          createdAt: contract.createdAt,
          updatedAt: contract.updatedAt,
        };
      }),
    };
  }

  async createCreatorReferralContract(params: {
    referrerCreatorId: string;
    referredCreatorId: string;
    percent: number;
  }) {
    const { referrerCreatorId, referredCreatorId, percent } = params;

    if (percent <= 0 || percent > 100) {
      throw new BadRequestException(
        'El porcentaje de referido debe estar entre 0 (exclusivo) y 100.',
      );
    }

    if (referrerCreatorId === referredCreatorId) {
      throw new BadRequestException('No se permite autorreferido.');
    }

    const [referrer, referred, existing] = await Promise.all([
      this.prisma.user.findUnique({
        where: { id: referrerCreatorId },
        select: { id: true, role: true, referralCode: true, firstName: true },
      }),
      this.prisma.user.findUnique({
        where: { id: referredCreatorId },
        select: { id: true, role: true },
      }),
      this.prisma.creatorReferral.findFirst({
        where: {
          OR: [{ referredCreatorId }, { referredUserId: referredCreatorId }],
        },
        select: { id: true, status: true },
      }),
    ]);

    if (!referrer || !referred) {
      throw new NotFoundException('Creador de contenido no encontrado.');
    }

    if (referrer.role !== UserRole.ANFITRIONA || referred.role !== UserRole.ANFITRIONA) {
      throw new BadRequestException(
        'Ambos usuarios deben ser creadores de contenido.',
      );
    }

    if (existing) {
      throw new BadRequestException(
        'El creador referido ya tiene un contrato de referido registrado.',
      );
    }

    const referralCode = referrer.referralCode ?? (await this.ensureCreatorReferralCode(referrer.id));
    return this.prisma.creatorReferral.create({
      data: {
        referrerCreatorId,
        referredCreatorId,
        referredUserId: referredCreatorId,
        referralCodeUsed: referralCode,
        percent: this.roundToTwo(percent),
        status: CreatorReferralStatus.ACTIVE,
        qualifiedAt: new Date(),
      },
    });
  }

  async updateCreatorReferralContract(
    id: string,
    params: { percent?: number; status?: CreatorReferralStatus },
  ) {
    const referral = await this.prisma.creatorReferral.findUnique({
      where: { id },
      select: { id: true, referredCreatorId: true, percent: true, status: true },
    });

    if (!referral || !referral.referredCreatorId) {
      throw new NotFoundException('Contrato de referido no encontrado.');
    }

    if (
      params.percent !== undefined &&
      (params.percent < 0 || params.percent > 100)
    ) {
      throw new BadRequestException(
        'El porcentaje de referido debe estar entre 0 y 100.',
      );
    }

    const nextStatus = params.status ?? referral.status;
    const nextPercent =
      params.percent !== undefined ? params.percent : Number(referral.percent ?? 0);

    if (nextStatus === CreatorReferralStatus.ACTIVE && !(nextPercent > 0)) {
      throw new BadRequestException(
        'Para activar un contrato, el porcentaje debe ser mayor a 0.',
      );
    }

    const data: Prisma.CreatorReferralUpdateInput = {
      ...(params.percent !== undefined
        ? { percent: this.roundToTwo(params.percent) }
        : {}),
      ...(params.status ? { status: params.status } : {}),
    };

    return this.prisma.creatorReferral.update({
      where: { id },
      data,
    });
  }

  async disableCreatorReferralContract(id: string) {
    return this.updateCreatorReferralContract(id, {
      status: CreatorReferralStatus.DISABLED,
    });
  }

  async maybeRewardCreatorReferralFromEarning(input: EarningRewardInput) {
    const {
      referredCreatorId,
      sourceEarningAmount,
      sourceEarningTransactionId,
      sourceType,
      purchaseCreatorId,
    } = input;

    if (!sourceEarningTransactionId) {
      return { skipped: true, reason: 'missing_source_transaction' as const };
    }

    if (!(sourceEarningAmount > 0)) {
      return { skipped: true, reason: 'invalid_source_amount' as const };
    }

    const referral = await this.prisma.creatorReferral.findFirst({
      where: {
        referredCreatorId,
        status: CreatorReferralStatus.ACTIVE,
      },
      select: {
        id: true,
        status: true,
        referredUserId: true,
        referredCreatorId: true,
        referrerCreatorId: true,
        percent: true,
      },
    });

    if (!referral || referral.status !== CreatorReferralStatus.ACTIVE) {
      return { skipped: true, reason: 'no_active_referral' as const };
    }

    const percentNumber = Number(referral.percent ?? 0);
    if (!(percentNumber > 0)) {
      return { skipped: true, reason: 'percent_zero' as const };
    }

    const rewardAmount = this.roundToTwo((sourceEarningAmount * percentNumber) / 100);
    if (!rewardAmount.gt(0)) {
      return { skipped: true, reason: 'reward_zero' as const };
    }

    try {
      const result = await this.prisma.$transaction(async (tx) => {
        const existing = await tx.creatorReferralRewardEvent.findUnique({
          where: { sourceTransactionId: sourceEarningTransactionId },
        });
        if (existing) {
          return { alreadyProcessed: true as const, existing };
        }

        const wallet = await tx.wallet.upsert({
          where: { userId: referral.referrerCreatorId },
          create: { userId: referral.referrerCreatorId, balance: 0 },
          update: {},
        });

        const rewardTransaction = await tx.transaction.create({
          data: {
            walletId: wallet.id,
            type: TransactionType.REFERRAL_CREATOR_REWARD,
            amount: rewardAmount,
            description: JSON.stringify({
              service: 'Comision por referido de creador',
              referredCreatorId,
              sourceType: sourceType ?? null,
              sourceEarningTransactionId,
              purchaseCreatorId: purchaseCreatorId ?? null,
            }),
          },
        });

        await tx.wallet.update({
          where: { id: wallet.id },
          data: {
            balance: {
              increment: rewardAmount,
            },
          },
        });

        const rewardEvent = await tx.creatorReferralRewardEvent.create({
          data: {
            referralId: referral.id,
            referrerCreatorId: referral.referrerCreatorId,
            referredUserId: referral.referredUserId ?? referral.referredCreatorId,
            referredCreatorId: referral.referredCreatorId,
            purchaseCreatorId: purchaseCreatorId ?? null,
            sourceTransactionId: sourceEarningTransactionId,
            rewardTransactionId: rewardTransaction.id,
            sourceAmount: this.roundToTwo(sourceEarningAmount),
            percent: referral.percent,
            rewardAmount,
            status: CreatorReferralRewardStatus.PAID,
          },
        });

        return { alreadyProcessed: false as const, rewardEvent };
      });

      if (result.alreadyProcessed) {
        return { skipped: true, reason: 'already_processed' as const };
      }

      return { skipped: false, rewardEventId: result.rewardEvent.id };
    } catch (error) {
      if (
        error instanceof Prisma.PrismaClientKnownRequestError &&
        error.code === 'P2002'
      ) {
        return { skipped: true, reason: 'already_processed' as const };
      }
      this.logger.error(
        `Error al acreditar comision de referido (sourceEarningTransactionId=${sourceEarningTransactionId})`,
        error instanceof Error ? error.stack : undefined,
      );
      throw error;
    }
  }
}



