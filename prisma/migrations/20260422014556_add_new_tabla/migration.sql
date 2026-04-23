-- AlterEnum
ALTER TYPE "TransactionType" ADD VALUE 'CHAT_IMAGE_UNLOCK';

-- AlterTable
ALTER TABLE "messages" ADD COLUMN     "imagePublicId" TEXT,
ADD COLUMN     "imageUrl" TEXT,
ALTER COLUMN "text" DROP NOT NULL;

-- CreateTable
CREATE TABLE "message_image_unlocks" (
    "id" TEXT NOT NULL,
    "messageId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "creditsSpent" INTEGER NOT NULL,
    "transactionId" TEXT,
    "unlockedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "message_image_unlocks_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "message_image_unlocks_transactionId_key" ON "message_image_unlocks"("transactionId");

-- CreateIndex
CREATE UNIQUE INDEX "message_image_unlocks_messageId_userId_key" ON "message_image_unlocks"("messageId", "userId");

-- AddForeignKey
ALTER TABLE "message_image_unlocks" ADD CONSTRAINT "message_image_unlocks_messageId_fkey" FOREIGN KEY ("messageId") REFERENCES "messages"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "message_image_unlocks" ADD CONSTRAINT "message_image_unlocks_transactionId_fkey" FOREIGN KEY ("transactionId") REFERENCES "transactions"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "message_image_unlocks" ADD CONSTRAINT "message_image_unlocks_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
