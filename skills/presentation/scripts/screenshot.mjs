// screenshot.mjs — Screenshot a Frontend Slides HTML file at 1920×1080.
//
// Usage:
//   node screenshot.mjs <html-path> <png-out-path> [slide-index]
//
// Serves the HTML over HTTP so Google Fonts load correctly. Forces the
// .deck-stage to render at 1:1 so the screenshot captures the design at
// its authored 1920×1080, regardless of the user's viewport.
//
// For multi-slide decks, passes the slide-index (0-based) to activate
// the right .slide before capturing. Defaults to slide 0.

import { chromium } from 'playwright';
import { createServer } from 'http';
import { readFileSync } from 'fs';
import { join, extname, dirname, basename } from 'path';

const HTML_PATH  = process.argv[2];
const OUT_PATH   = process.argv[3];
const SLIDE_IDX  = parseInt(process.argv[4] ?? '0', 10);

if (!HTML_PATH || !OUT_PATH) {
  console.error('Usage: node screenshot.mjs <html-path> <png-out-path> [slide-index]');
  process.exit(1);
}

const SERVE_DIR = dirname(HTML_PATH);
const HTML_FILE = basename(HTML_PATH);

const MIME = {
  '.html':'text/html', '.css':'text/css', '.js':'application/javascript',
  '.json':'application/json', '.png':'image/png', '.jpg':'image/jpeg',
  '.jpeg':'image/jpeg', '.svg':'image/svg+xml', '.webp':'image/webp',
  '.woff':'font/woff', '.woff2':'font/woff2', '.ttf':'font/ttf',
};

const server = createServer((req, res) => {
  const url = decodeURIComponent(req.url);
  const path = join(SERVE_DIR, url === '/' ? HTML_FILE : url);
  try {
    const body = readFileSync(path);
    res.writeHead(200, { 'Content-Type': MIME[extname(path).toLowerCase()] || 'application/octet-stream' });
    res.end(body);
  } catch {
    res.writeHead(404); res.end('not found');
  }
});

const port = await new Promise(r => server.listen(0, () => r(server.address().port)));

const browser = await chromium.launch();
const page = await browser.newPage({
  viewport: { width: 1920, height: 1080 },
  deviceScaleFactor: 2,  // retina-grade output for crisp PPT embedding
});

await page.goto(`http://localhost:${port}/`, { waitUntil: 'networkidle' });
await page.evaluate(() => document.fonts.ready);

// Activate the requested slide (for multi-slide decks) and force the
// stage to render at 1:1 inside the 1920×1080 viewport.
await page.evaluate((idx) => {
  const slides = document.querySelectorAll('.slide');
  if (slides.length > 1) {
    slides.forEach((s, i) => {
      s.classList.toggle('active', i === idx);
      s.classList.toggle('visible', i === idx);
    });
  }
  const stage = document.querySelector('.deck-stage');
  if (stage) stage.style.transform = 'translate(0,0) scale(1)';
}, SLIDE_IDX);

// Let entrance animations settle so the final visual state is captured.
await page.waitForTimeout(1800);

await page.screenshot({
  path: OUT_PATH,
  fullPage: false,
  clip: { x: 0, y: 0, width: 1920, height: 1080 },
});

console.log(`wrote ${OUT_PATH}`);

await browser.close();
server.close();
