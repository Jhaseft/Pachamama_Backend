-- CreateEnum
CREATE TYPE "WithdrawalMethodType" AS ENUM ('BCP', 'OTHER_BANK', 'PAYPAL');

-- AlterTable bank_accounts
ALTER TABLE "bank_accounts"
  ADD COLUMN "type" "WithdrawalMethodType" NOT NULL DEFAULT 'BCP',
  ADD COLUMN "paypalEmail" TEXT,
  ALTER COLUMN "bankId" DROP NOT NULL,
  ALTER COLUMN "accountNumber" DROP NOT NULL;

-- AlterTable withdrawal_requests
ALTER TABLE "withdrawal_requests"
  ADD COLUMN "payoutCurrency" TEXT NOT NULL DEFAULT 'PEN';
