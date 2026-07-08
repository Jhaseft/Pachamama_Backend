const { Pool } = require('pg');
require('dotenv').config();

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

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
  const client = await pool.connect();
  try {
    console.log('🚀 Iniciando inserción de redes sociales...');

    for (const network of socialNetworks) {
      try {
        const result = await client.query(
          'INSERT INTO social_networks (id, name, "iconPublicId", "createdAt", "updatedAt") VALUES (gen_random_uuid(), $1, $2, NOW(), NOW()) ON CONFLICT (name) DO NOTHING RETURNING id',
          [network.name, network.iconPublicId]
        );

        if (result.rows.length > 0) {
          console.log(`✨ ${network.name} creada exitosamente`);
        } else {
          console.log(`✅ ${network.name} ya existe`);
        }
      } catch (error) {
        console.error(`❌ Error al insertar ${network.name}:`, error.message);
      }
    }

    console.log('✅ Todas las redes sociales han sido procesadas');
  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  } finally {
    client.release();
    await pool.end();
  }
}

main();
