// Runtime parity test for the ported economy engine.
//
// Compiles src/lib/{treats,economy}.ts to a temp dir and asserts the economy
// behaves as the SwiftUI original did on known scenarios. Run:
//   node scripts/economy.test.mjs
//
// Uses local-midnight day boundaries, so it fixes a timezone for determinism.

import { execSync } from 'node:child_process';
import { mkdtempSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { pathToFileURL } from 'node:url';

process.env.TZ = 'America/New_York';

const out = mkdtempSync(join(tmpdir(), 'toofies-econ-'));
execSync(
  `npx tsc src/lib/economy.ts src/lib/treats.ts --outDir ${out} --ignoreConfig ` +
    `--module esnext --moduleResolution bundler --target es2022 --skipLibCheck`,
  { stdio: 'inherit' },
);

const econ = await import(pathToFileURL(join(out, 'economy.js')).href);
const { makeEntry } = await import(pathToFileURL(join(out, 'treats.js')).href);

let failures = 0;
function check(name, got, want) {
  const ok = JSON.stringify(got) === JSON.stringify(want);
  if (!ok) {
    failures++;
    console.error(`✗ ${name}\n    got:  ${JSON.stringify(got)}\n    want: ${JSON.stringify(want)}`);
  } else {
    console.log(`✓ ${name}`);
  }
}

const at = (y, m, d, h = 12) => new Date(y, m - 1, d, h, 0, 0);

// —— Scenario A: fresh install, nothing logged ———————————————————————————————
{
  const now = at(2026, 7, 14);
  const s = econ.initialState(now);
  check('A: balance is 0 on install day', econ.balance(s, now), 0);
  check('A: no recency yet', econ.daysSinceLastDessert(s, now), null);
  check('A: clean so far today', econ.isCleanSoFarToday(s, now), true);
  check('A: on-plan streak counts install day', econ.onPlanStreak(s, now), 1);
  check('A: pending today = clean-day points', econ.pendingPointsToday(s, now), 10);
}

// —— Scenario B: 5 clean days elapsed, still nothing logged —————————————————
{
  const install = at(2026, 7, 9);
  const now = at(2026, 7, 14);
  const s = { ...econ.initialState(install), installDate: install.toISOString() };
  // 5 completed clean days (Jul 9–13) → 5 × 10 = 50 banked; Jul 14 pends.
  check('B: banks 10/clean-day → 50', econ.balance(s, now), 50);
  const av = econ.availability(s, now);
  check('B: 50 pts affords one 30-pt dessert', av.affordable, true);
  check('B: banked desserts = 1', av.bankedDesserts, 1);
  check('B: on-plan streak = 6 days', econ.onPlanStreak(s, now), 6);
}

// —— Scenario C: log a dessert today, price debits, recency resets ——————————
{
  const install = at(2026, 7, 9);
  const now = at(2026, 7, 14, 15);
  const s = { ...econ.initialState(install), installDate: install.toISOString() };
  s.entries = [makeEntry('cookie', s.dessertCost, at(2026, 7, 14, 14), 'e1')];
  // 50 banked from Jul 9–13; today's dessert debits 30 → 20; today no longer clean.
  check('C: balance after 30-pt dessert = 20', econ.balance(s, now), 20);
  check('C: recency = 0 days (had one today)', econ.daysSinceLastDessert(s, now), 0);
  check('C: not clean today anymore', econ.isCleanSoFarToday(s, now), false);
  // Earned dessert must NOT break the streak (had the points).
  check('C: streak intact after affordable dessert', econ.onPlanStreak(s, now), 6);
}

// —— Scenario D: overspend → forgiven (floor 0), streak pauses that day ——————
{
  const install = at(2026, 7, 13);
  const now = at(2026, 7, 14, 15);
  const s = { ...econ.initialState(install), installDate: install.toISOString() };
  // Only Jul 13 completed → 10 banked. A 30-pt dessert today outruns it.
  s.entries = [makeEntry('cake', s.dessertCost, at(2026, 7, 14, 14), 'e2')];
  check('D: unaffordable dessert forgiven, balance floors at 0', econ.balance(s, now), 0);
  check('D: overspend pauses streak today → 0', econ.onPlanStreak(s, now), 0);
}

// —— Scenario E: activity points from steps, with Health connected ——————————
{
  check('E: 1,500 steps = 1 pt', econ.activityPoints(1500), 1);
  check('E: 21,000 steps = 14 pts (below cap)', econ.activityPoints(21000), 14);
  check('E: 30,000 steps caps at 15', econ.activityPoints(30000), 15);
  check('E: 0 steps = 0 pt', econ.activityPoints(0), 0);
}

console.log(failures === 0 ? '\nALL PASS' : `\n${failures} FAILURE(S)`);
process.exit(failures === 0 ? 0 : 1);
