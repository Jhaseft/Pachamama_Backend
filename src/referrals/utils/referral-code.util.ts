const ALPHABET = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

function randomChunk(length: number): string {
  let result = '';
  for (let i = 0; i < length; i += 1) {
    const index = Math.floor(Math.random() * ALPHABET.length);
    result += ALPHABET[index];
  }
  return result;
}

export function buildReferralCode(seed?: string): string {
  const normalizedSeed = (seed ?? '')
    .toUpperCase()
    .replace(/[^A-Z0-9]/g, '')
    .slice(0, 4);

  const prefix = normalizedSeed.length > 0 ? normalizedSeed : 'CRTR';
  return `${prefix}${randomChunk(4)}`;
}
