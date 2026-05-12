import { PrismaClient } from "@prisma/client";
import { PrismaPg } from "@prisma/adapter-pg";
import { Pool } from "pg";
import bcrypt from "bcrypt";
import "dotenv/config";

const pool = new Pool({ connectionString: process.env.DATABASE_URL });
const adapter = new PrismaPg(pool);
const prisma = new PrismaClient({ adapter });

async function main() {
  const hashedPassword = await bcrypt.hash("anfitriona123", 10);

  const user = await prisma.user.create({
    data: {
      phoneNumber: "+51999000001",
      email: "anfitriona.test@pachamama.com",
      password: hashedPassword,
      firstName: "Ana",
      lastName: "Torres",
      role: "ANFITRIONA",
      isProfileComplete: true,
      anfitrionaProfile: {
        create: {
          username: "ana_torres",
          cedula: "00000001",
          dateOfBirth: new Date("1995-06-15"),
        },
      },
      wallet: {
        create: {
          balance: 0,
        },
      },
    },
    include: {
      anfitrionaProfile: true,
      wallet: true,
    },
  });

  console.log("✅ Anfitriona creada:");
  console.log("   Email:      anfitriona.test@pachamama.com");
  console.log("   Contraseña: anfitriona123");
  console.log("   Rol:        ANFITRIONA");
  console.log("   ID:         " + user.id);
}

main()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
