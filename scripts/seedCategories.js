const { Pool } = require('pg');
require('dotenv').config();

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

// Categorías estilo TikTok (tomadas de "Explora creadores por categoría").
// `icon` se deja en null: las imágenes reales se cargan después.
const categories = [
  { name: 'Lifestyle', slug: 'lifestyle', description: 'Inspiración diaria, vlogs y momentos reales.' },
  { name: 'Fitness', slug: 'fitness', description: 'Entrenamiento, nutrición y vida saludable.' },
  { name: 'Música', slug: 'musica', description: 'Cantantes, músicos y talento en vivo.' },
  { name: 'Gaming', slug: 'gaming', description: 'Gamers, streams y contenido épico.' },
  { name: 'Educación', slug: 'educacion', description: 'Aprende algo nuevo cada día.' },
  { name: 'Belleza', slug: 'belleza', description: 'Tips, maquillaje, skincare y más.' },
  { name: 'Moda', slug: 'moda', description: 'Estilo, tendencias y outfits únicos.' },
  { name: 'Negocios', slug: 'negocios', description: 'Emprendimiento, finanzas y productividad.' },
  { name: 'Viajes', slug: 'viajes', description: 'Descubre lugares increíbles.' },
  { name: 'Tecnología', slug: 'tecnologia', description: 'Gadgets, reviews y novedades tech.' },
  { name: 'Salud', slug: 'salud', description: 'Bienestar físico y mental.' },
  { name: 'Humor', slug: 'humor', description: 'Risas, comedia y buen ambiente.' },
];

async function main() {
  const client = await pool.connect();
  try {
    console.log('🚀 Iniciando inserción de categorías...');

    for (const category of categories) {
      try {
        const result = await client.query(
          'INSERT INTO categories (id, name, slug, description, "isActive", "createdAt", "updatedAt") VALUES (gen_random_uuid(), $1, $2, $3, true, NOW(), NOW()) ON CONFLICT (name) DO NOTHING RETURNING id',
          [category.name, category.slug, category.description]
        );

        if (result.rows.length > 0) {
          console.log(`✨ ${category.name} creada exitosamente`);
        } else {
          console.log(`✅ ${category.name} ya existe`);
        }
      } catch (error) {
        console.error(`❌ Error al insertar ${category.name}:`, error.message);
      }
    }

    console.log('✅ Todas las categorías han sido procesadas');
  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  } finally {
    client.release();
    await pool.end();
  }
}

main();
