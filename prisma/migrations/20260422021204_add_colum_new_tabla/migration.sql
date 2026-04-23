/*
  Warnings:

  - Added the required column `imageUrl` to the `message_image_unlocks` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "message_image_unlocks" ADD COLUMN     "imageUrl" TEXT NOT NULL;
