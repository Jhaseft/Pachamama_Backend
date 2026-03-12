-- Add public profile fields to anfitrione_profiles
ALTER TABLE "anfitrione_profiles"
  ADD COLUMN "avatarUrl"      TEXT,
  ADD COLUMN "avatarPublicId" TEXT,
  ADD COLUMN "bio"            TEXT,
  ADD COLUMN "rateCredits"    INTEGER,
  ADD COLUMN "isOnline"       BOOLEAN NOT NULL DEFAULT false;

-- Create anfitrione_images table
CREATE TABLE "anfitrione_images" (
    "id"        TEXT NOT NULL,
    "profileId" TEXT NOT NULL,
    "url"       TEXT NOT NULL,
    "publicId"  TEXT,
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "anfitrione_images_pkey" PRIMARY KEY ("id")
);

-- Foreign key: anfitrione_images → anfitrione_profiles (cascade delete)
ALTER TABLE "anfitrione_images"
  ADD CONSTRAINT "anfitrione_images_profileId_fkey"
  FOREIGN KEY ("profileId") REFERENCES "anfitrione_profiles"("id")
  ON DELETE CASCADE ON UPDATE CASCADE;
