-- CreateEnum
CREATE TYPE "BinanceIntentStatus" AS ENUM ('PENDING', 'CONFIRMED', 'REJECTED', 'EXPIRED');

-- CreateTable
CREATE TABLE "binance_deposit_intents" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "packageId" TEXT NOT NULL,
    "packageName" TEXT NOT NULL,
    "creditsToDeliver" INTEGER NOT NULL,
    "network" TEXT NOT NULL,
    "coin" TEXT NOT NULL,
    "walletAddress" TEXT NOT NULL,
    "expectedAmount" DECIMAL(20,8) NOT NULL,
    "microDelta" DECIMAL(20,8) NOT NULL,
    "txid" TEXT,
    "status" "BinanceIntentStatus" NOT NULL DEFAULT 'PENDING',
    "failureReason" TEXT,
    "binanceData" JSONB,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "confirmedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "binance_deposit_intents_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "binance_deposit_intents_txid_key" ON "binance_deposit_intents"("txid");

-- CreateIndex
CREATE INDEX "binance_deposit_intents_userId_status_idx" ON "binance_deposit_intents"("userId", "status");

-- CreateIndex
CREATE INDEX "binance_deposit_intents_status_expiresAt_idx" ON "binance_deposit_intents"("status", "expiresAt");

-- AddForeignKey
ALTER TABLE "binance_deposit_intents" ADD CONSTRAINT "binance_deposit_intents_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "binance_deposit_intents" ADD CONSTRAINT "binance_deposit_intents_packageId_fkey" FOREIGN KEY ("packageId") REFERENCES "packages"("id") ON DELETE NO ACTION ON UPDATE CASCADE;
