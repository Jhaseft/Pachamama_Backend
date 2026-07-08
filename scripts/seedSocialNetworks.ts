import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

const socialNetworks = [
  {
    name: 'Instagram',
    iconPublicId: 'https://res.cloudinary.com/dh2ytqnwm/image/upload/v1720000000/social-icons/instagram.png',
  },
  {
    name: 'TikTok',
    iconPublicId: 'https://res.cloudinary.com/dh2ytqnwm/image/upload/v1720000000/social-icons/tiktok.png',
  },
  {
    name: 'Twitter',
    iconPublicId: 'https://res.cloudinary.com/dh2ytqnwm/image/upload/v1720000000/social-icons/twitter.png',
  },
  {
    name: 'Facebook',
    iconPublicId: 'https://res.cloudinary.com/dh2ytqnwm/image/upload/v1720000000/social-icons/facebook.png',
  },
  {
    name: 'YouTube',
    iconPublicId: 'https://res.cloudinary.com/dh2ytqnwm/image/upload/v1720000000/social-icons/youtube.png',
  },
  {
    name: 'Twitch',
    iconPublicId: 'https://res.cloudinary.com/dh2ytqnwm/image/upload/v1720000000/social-icons/twitch.png',
  },
  {
    name: 'Snapchat',
    iconPublicId: 'https://res.cloudinary.com/dh2ytqnwm/image/upload/v1720000000/social-icons/snapchat.png',
  },
  {
    name: 'LinkedIn',
    iconPublicId: 'https://res.cloudinary.com/dh2ytqnwm/image/upload/v1720000000/social-icons/linkedin.png',
  },
  {
    name: 'WhatsApp',
    iconPublicId: 'https://res.cloudinary.com/dh2ytqnwm/image/upload/v1720000000/social-icons/whatsapp.png',
  },
  {
    name: 'Telegram',
    iconPublicId: 'https://res.cloudinary.com/dh2ytqnwm/image/upload/v1720000000/social-icons/telegram.png',
  },
];

async function main() {
  try {
    console.log('🚀 Iniciando inserción de redes sociales...');

    for (const network of socialNetworks) {
      const existing = await prisma.socialNetwork.findUnique({
        where: { name: network.name },
      });

      if (existing) {
        console.log(`✅ ${network.name} ya existe`);
      } else {
        const created = await prisma.socialNetwork.create({
          data: network,
        });
        console.log(`✨ ${created.name} creada exitosamente`);
      }
    }

    console.log('✅ Todas las redes sociales han sido procesadas');
  } catch (error) {
    console.error('❌ Error:', error);
    process.exit(1);
  } finally {
    await prisma.$disconnect();
  }
}

main();
