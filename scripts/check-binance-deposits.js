const crypto = require('crypto');
const fs = require('fs');
const path = require('path');

const envText = fs.readFileSync(path.join(__dirname, '..', '.env'), 'utf8');
const env = Object.fromEntries(
  envText
    .split(/\r?\n/)
    .filter((l) => l && !l.startsWith('#') && l.includes('='))
    .map((l) => {
      const idx = l.indexOf('=');
      return [l.slice(0, idx).trim(), l.slice(idx + 1).trim()];
    }),
);

const apiKey = env.BINANCE_API_KEY;
const apiSecret = env.BINANCE_API_SECRET;
const baseUrl = env.BINANCE_API_BASE_URL || 'https://api.binance.com';
const coin = env.BINANCE_COIN || 'USDT';

// Últimos 30 días (Binance permite hasta 90)
const startTime = Date.now() - 30 * 24 * 60 * 60 * 1000;

const params = new URLSearchParams({
  coin,
  startTime: String(startTime),
  timestamp: String(Date.now()),
  recvWindow: '10000',
  limit: '1000',
});

const signature = crypto
  .createHmac('sha256', apiSecret)
  .update(params.toString())
  .digest('hex');
params.append('signature', signature);

const url = `${baseUrl}/sapi/v1/capital/deposit/hisrec?${params.toString()}`;

(async () => {
  try {
    const resp = await fetch(url, {
      method: 'GET',
      headers: { 'X-MBX-APIKEY': apiKey },
    });
    const data = await resp.json();
    console.log('HTTP:', resp.status);
    console.log('Total depositos hoy:', Array.isArray(data) ? data.length : 'N/A');
    console.log(JSON.stringify(data, null, 2));
  } catch (e) {
    console.error('Error:', e);
  }
})();
