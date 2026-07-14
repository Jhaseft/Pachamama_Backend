-- CreateTable
CREATE TABLE "web_push_credentials" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "userAgent" TEXT,
    "lastSeenAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "web_push_credentials_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "web_push_credentials_token_key" ON "web_push_credentials"("token");

-- CreateIndex
CREATE INDEX "web_push_credentials_userId_idx" ON "web_push_credentials"("userId");

-- AddForeignKey
ALTER TABLE "web_push_credentials" ADD CONSTRAINT "web_push_credentials_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
