#!/usr/bin/env node
/**
 * Mobbin puller — run on your Mac (open network + your Mobbin login).
 *
 * First run: a browser window opens. Log into Mobbin once — the session is
 * saved to ./.mobbin-profile so you won't need to log in again.
 *
 * Then pull any app's screens straight into the design library:
 *   node pull.mjs <app-name> "<mobbin screens URL>"
 *
 * Example:
 *   node pull.mjs strava "https://mobbin.com/apps/strava-ios-.../screens"
 *
 * Output: ../../.planning/design-library/<app-name>/screens/*.png
 */
import { chromium } from 'playwright';
import { fileURLToPath } from 'url';
import { dirname, resolve, join } from 'path';
import { mkdirSync, writeFileSync } from 'fs';

const __dirname = dirname(fileURLToPath(import.meta.url));
const [app, url] = process.argv.slice(2);

if (!app || !url) {
  console.error('Usage: node pull.mjs <app-name> "<mobbin screens or flows URL>"');
  process.exit(1);
}

const outDir = resolve(__dirname, '../../.planning/design-library', app, 'screens');
mkdirSync(outDir, { recursive: true });
const profileDir = join(__dirname, '.mobbin-profile');

const ctx = await chromium.launchPersistentContext(profileDir, {
  headless: false,              // headed so you can log in / watch it work
  viewport: { width: 1440, height: 2000 },
});
const page = ctx.pages()[0] || await ctx.newPage();
await page.goto(url, { waitUntil: 'domcontentloaded', timeout: 60000 });
await page.waitForTimeout(4000);

// Gate check — if signed out, pause for you to log in, then continue.
const gated = await page.evaluate(() =>
  /log in|sign up|join for free/i.test(document.body.innerText) &&
  document.querySelectorAll('img').length < 6
);
if (gated) {
  console.log('\n⚠  Not logged into Mobbin yet.');
  console.log('   Log in in the open window, then press Enter here to continue…');
  await new Promise((r) => process.stdin.once('data', r));
  await page.goto(url, { waitUntil: 'domcontentloaded' });
  await page.waitForTimeout(4000);
}

// Lazy-load everything: scroll to the bottom in steps.
let prev = 0;
for (let i = 0; i < 40; i++) {
  await page.evaluate(() => window.scrollBy(0, 1400));
  await page.waitForTimeout(700);
  const h = await page.evaluate(() => document.body.scrollHeight);
  if (h === prev) break;
  prev = h;
}
await page.waitForTimeout(1500);

// Collect the screen images (large images; skip logos/avatars/icons).
const srcs = await page.evaluate(() =>
  [...document.querySelectorAll('img')]
    .filter((i) => i.naturalWidth > 220 && i.naturalHeight > 300)
    .map((i) => i.currentSrc || i.src)
    .filter((s) => s && s.startsWith('http'))
);
const unique = [...new Set(srcs)];
console.log(`Found ${unique.length} screen images for "${app}".`);

let n = 0;
for (const src of unique) {
  try {
    const resp = await ctx.request.get(src);      // uses your logged-in cookies
    if (!resp.ok()) continue;
    const buf = await resp.body();
    const pad = String(++n).padStart(3, '0');
    writeFileSync(join(outDir, `${app}-${pad}.png`), buf);
  } catch (e) { /* skip a failed image */ }
}

// Full-page backup capture too.
await page.screenshot({ path: join(outDir, `${app}-fullpage.png`), fullPage: true });

console.log(`\n✅ Saved ${n} screens + a full-page capture to:\n   ${outDir}`);
console.log('   Commit them, or tell Claude they are there and it will catalog them.');
await ctx.close();
