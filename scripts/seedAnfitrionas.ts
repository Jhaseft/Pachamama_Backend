import 'dotenv/config';
import { PrismaClient } from '@prisma/client';
import { PrismaPg } from '@prisma/adapter-pg';
import { Pool } from 'pg';

const pool = new Pool({ connectionString: process.env.DATABASE_URL });
const adapter = new PrismaPg(pool);
const prisma = new PrismaClient({ adapter } as any);

const IMAGES = [
  'https://res.cloudinary.com/dshtp6fga/image/upload/v1773798719/0bac1212-44ad-4094-9d23-8319136783fe_scgbbe.jpg',
  'https://res.cloudinary.com/dshtp6fga/image/upload/v1773798744/22f55e79-db75-4f06-9e7d-8a52a106d7e4_duw6tw.jpg',
  'https://res.cloudinary.com/dshtp6fga/image/upload/v1773798739/61b862ac-b58c-4838-85dd-8d484fb3ed84_i3peyq.jpg',
  'https://res.cloudinary.com/dshtp6fga/image/upload/v1773798714/93efb239-2add-4489-8152-ba44ee7b758c_ekqhwi.jpg',
];

const ANFITRIONAS = [
  {
    firstName: 'Sofia',
    lastName: 'Martínez',
    phoneNumber: '5551000001',
    username: 'sofia_m',
    bio: 'Conversaciones auténticas y llenas de energía ✨',
    rateCredits: 10,
    isOnline: true,
    dateOfBirth: new Date('1997-04-12'),
    cedula: '1000000001',
  },
  {
    firstName: 'Valentina',
    lastName: 'Gómez',
    phoneNumber: '5551000002',
    username: 'vale_gomez',
    bio: 'Me encanta conocer gente nueva 🌸',
    rateCredits: 12,
    isOnline: true,
    dateOfBirth: new Date('1999-07-23'),
    cedula: '1000000002',
  },
  {
    firstName: 'Camila',
    lastName: 'Rodríguez',
    phoneNumber: '5551000003',
    username: 'cami_r',
    bio: 'Risas garantizadas en cada charla 😊',
    rateCredits: 8,
    isOnline: false,
    dateOfBirth: new Date('1998-01-30'),
    cedula: '1000000003',
  },
  {
    firstName: 'Isabella',
    lastName: 'López',
    phoneNumber: '5551000004',
    username: 'isabella_l',
    bio: 'Cada conversación es una nueva aventura 🦋',
    rateCredits: 15,
    isOnline: false,
    dateOfBirth: new Date('1996-11-05'),
    cedula: '1000000004',
  },
];

async function main() {
  // 1. Encontrar todas las anfitrionas existentes
  const existing = await prisma.user.findMany({
    where: { role: 'ANFITRIONA' },
    select: { id: true, firstName: true },
  });
  const existingIds = existing.map((u) => u.id);

  if (existingIds.length > 0) {
    console.log(`Eliminando ${existingIds.length} anfitrionas existentes...`);

    // Eliminar historyViews donde estas usuarias son las que vieron (como espectadoras)
    await prisma.historyView.deleteMany({ where: { userId: { in: existingIds } } });

    // Eliminar perfiles (cascade a anfitrione_images)
    await prisma.anfitrioneProfile.deleteMany({ where: { userId: { in: existingIds } } });

    // Eliminar usuarios (cascade a histories, history_views de sus historias, likes, wallets)
    await prisma.user.deleteMany({ where: { id: { in: existingIds } } });

    console.log('Anfitrionas anteriores eliminadas.');
  }

  // 2. Crear 4 anfitrionas nuevas
  console.log('\nCreando 4 anfitrionas...');

  for (let i = 0; i < ANFITRIONAS.length; i++) {
    const data = ANFITRIONAS[i];
    const imageUrl = IMAGES[i];

    const user = await prisma.user.create({
      data: {
        phoneNumber: data.phoneNumber,
        firstName: data.firstName,
        lastName: data.lastName,
        role: 'ANFITRIONA',
        isActive: true,
        isProfileComplete: true,
      },
    });

    await prisma.anfitrioneProfile.create({
      data: {
        userId: user.id,
        username: data.username,
        bio: data.bio,
        rateCredits: data.rateCredits,
        isOnline: data.isOnline,
        avatarUrl: imageUrl,
        dateOfBirth: data.dateOfBirth,
        cedula: data.cedula,
        images: {
          create: [{ url: imageUrl, sortOrder: 0 }],
        },
      },
    });

    // Historia publicada ahora → aparece en el feed (válida 24 hrs)
    await prisma.history.create({
      data: {
        userId: user.id,
        mediaUrl: imageUrl,
        mediaType: 'IMAGE',
        priceCredits: 0,
        publishedAt: new Date(),
      },
    });

    console.log(`  ✓ ${data.firstName} ${data.lastName} (@${data.username})`);
  }

  console.log('\n¡Seed completado! 4 anfitrionas listas en el feed.');
}

main()
  .catch((e) => {
    console.error('Error en el seed:', e);
    process.exit(1);
  })
  .finally(() => prisma.$disconnect());
