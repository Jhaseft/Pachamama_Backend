-- AlterTable
ALTER TABLE "creator_referrals"
  ADD COLUMN "referredCreatorId" TEXT,
  ADD COLUMN "percent" DECIMAL(5,2) NOT NULL DEFAULT 0,
  ALTER COLUMN "referredUserId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "creator_referral_reward_events"
  ADD COLUMN "referredCreatorId" TEXT,
  ALTER COLUMN "referredUserId" DROP NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "creator_referrals_referredCreatorId_key" ON "creator_referrals"("referredCreatorId");

-- CreateIndex
CREATE INDEX "creator_referrals_referredCreatorId_idx" ON "creator_referrals"("referredCreatorId");

-- CreateIndex
CREATE INDEX "creator_referral_reward_events_referredCreatorId_idx" ON "creator_referral_reward_events"("referredCreatorId");

-- AddForeignKey
ALTER TABLE "creator_referrals"
  ADD CONSTRAINT "creator_referrals_referredCreatorId_fkey"
  FOREIGN KEY ("referredCreatorId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "creator_referral_reward_events"
  ADD CONSTRAINT "creator_referral_reward_events_referredCreatorId_fkey"
  FOREIGN KEY ("referredCreatorId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;
