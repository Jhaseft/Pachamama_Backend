-- CreateEnum
CREATE TYPE "CreatorReferralStatus" AS ENUM ('ACTIVE', 'DISABLED');

-- CreateEnum
CREATE TYPE "CreatorReferralRewardStatus" AS ENUM ('PAID', 'REVERSED');

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "TransactionType" ADD VALUE 'REFERRAL_CREATOR_REWARD';
ALTER TYPE "TransactionType" ADD VALUE 'REFERRAL_CREATOR_REWARD_REVERSAL';

-- AlterTable
ALTER TABLE "users" ADD COLUMN     "referralCode" TEXT;

-- CreateTable
CREATE TABLE "creator_referrals" (
    "id" TEXT NOT NULL,
    "referrerCreatorId" TEXT NOT NULL,
    "referredUserId" TEXT NOT NULL,
    "referralCodeUsed" TEXT NOT NULL,
    "status" "CreatorReferralStatus" NOT NULL DEFAULT 'ACTIVE',
    "qualifiedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "creator_referrals_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "creator_referral_settings" (
    "id" TEXT NOT NULL,
    "creatorId" TEXT NOT NULL,
    "percent" DECIMAL(5,2) NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "creator_referral_settings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "creator_referral_reward_events" (
    "id" TEXT NOT NULL,
    "referralId" TEXT NOT NULL,
    "referrerCreatorId" TEXT NOT NULL,
    "referredUserId" TEXT NOT NULL,
    "purchaseCreatorId" TEXT,
    "sourceTransactionId" TEXT NOT NULL,
    "rewardTransactionId" TEXT NOT NULL,
    "sourceAmount" DECIMAL(10,2) NOT NULL,
    "percent" DECIMAL(5,2) NOT NULL,
    "rewardAmount" DECIMAL(10,2) NOT NULL,
    "status" "CreatorReferralRewardStatus" NOT NULL DEFAULT 'PAID',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "reversedAt" TIMESTAMP(3),

    CONSTRAINT "creator_referral_reward_events_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "creator_referrals_referredUserId_key" ON "creator_referrals"("referredUserId");

-- CreateIndex
CREATE INDEX "creator_referrals_referrerCreatorId_idx" ON "creator_referrals"("referrerCreatorId");

-- CreateIndex
CREATE UNIQUE INDEX "creator_referral_settings_creatorId_key" ON "creator_referral_settings"("creatorId");

-- CreateIndex
CREATE UNIQUE INDEX "creator_referral_reward_events_sourceTransactionId_key" ON "creator_referral_reward_events"("sourceTransactionId");

-- CreateIndex
CREATE UNIQUE INDEX "creator_referral_reward_events_rewardTransactionId_key" ON "creator_referral_reward_events"("rewardTransactionId");

-- CreateIndex
CREATE INDEX "creator_referral_reward_events_referralId_idx" ON "creator_referral_reward_events"("referralId");

-- CreateIndex
CREATE INDEX "creator_referral_reward_events_referrerCreatorId_idx" ON "creator_referral_reward_events"("referrerCreatorId");

-- CreateIndex
CREATE INDEX "creator_referral_reward_events_referredUserId_idx" ON "creator_referral_reward_events"("referredUserId");

-- CreateIndex
CREATE UNIQUE INDEX "users_referralCode_key" ON "users"("referralCode");

-- AddForeignKey
ALTER TABLE "creator_referrals" ADD CONSTRAINT "creator_referrals_referrerCreatorId_fkey" FOREIGN KEY ("referrerCreatorId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "creator_referrals" ADD CONSTRAINT "creator_referrals_referredUserId_fkey" FOREIGN KEY ("referredUserId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "creator_referral_settings" ADD CONSTRAINT "creator_referral_settings_creatorId_fkey" FOREIGN KEY ("creatorId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "creator_referral_reward_events" ADD CONSTRAINT "creator_referral_reward_events_referralId_fkey" FOREIGN KEY ("referralId") REFERENCES "creator_referrals"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "creator_referral_reward_events" ADD CONSTRAINT "creator_referral_reward_events_referrerCreatorId_fkey" FOREIGN KEY ("referrerCreatorId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "creator_referral_reward_events" ADD CONSTRAINT "creator_referral_reward_events_referredUserId_fkey" FOREIGN KEY ("referredUserId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "creator_referral_reward_events" ADD CONSTRAINT "creator_referral_reward_events_purchaseCreatorId_fkey" FOREIGN KEY ("purchaseCreatorId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "creator_referral_reward_events" ADD CONSTRAINT "creator_referral_reward_events_sourceTransactionId_fkey" FOREIGN KEY ("sourceTransactionId") REFERENCES "transactions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "creator_referral_reward_events" ADD CONSTRAINT "creator_referral_reward_events_rewardTransactionId_fkey" FOREIGN KEY ("rewardTransactionId") REFERENCES "transactions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
