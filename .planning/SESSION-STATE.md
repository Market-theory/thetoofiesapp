# Toofies — Session State / Handoff

**Updated:** 2026-07-13

Read this first in a new session, alongside `CLAUDE.md` and `.planning/`.

## Where the product stands (ratified)

- **v1 = a careful-consumption + recency dessert tracker.** On-device only, no
  accounts, no paywall. See `DECISION-REGISTER.md` → "🟢 RATIFIED 2026-07-13".
- Points economy = an **opt-in experiment to validate**, not the core. Ship a
  "just track recency, no points" mode. Behavioral safeguards are LOCKED
  (`PRODUCT.md`): no celebrating abstinence, no cost/afford/spend language, no
  score-drop-as-penalty, don't frame steps as paying for dessert, ED-resource
  signposting. An ED-specialist review is a required gate before any earn/spend
  food mechanic ships (`ED-REVIEW-BRIEF.md`).
- Social sharing + dessert-place discovery + national directory = later layers
  (`VISION.md`), all still 🔴 OPEN. Disney was only an example, not a strategy
  (R7 closed).
- Design (colors/type/mascot/layout) = still 🔴 OPEN. A draft onboarding
  prototype exists at `prototype/onboarding/index.html` (patisserie palette +
  "Toofie" tooth character) — a proposal to react to, NOT decided.

## The current build vs ratified direction

The SwiftUI app (`Toofies/`) still leads with the economy and celebrates
"days on plan" (dessert-free days) — this **deviates** from the ratified
direction and is a tracked **reshape** item. Do not treat the built app as
final. It has never been compiled (no Mac/Xcode in the cloud sandbox).

## Immediate next task (where we stopped)

**Pulling Strava reference screens from Mobbin for the activity/health UI.**
- Network was the blocker: environment was on "Trusted" egress, which blocked
  Browserbase + Mobbin. Founder switched network access to **Full** — now
  `browserbase.com` and `mobbin.com` ARE reachable from the sandbox (verified).
- **Method that should now work:** start a Browserbase session (MCP:
  `mcp__…browserbase…__start`), get its `cdpUrl`, then connect local Playwright
  over CDP (`chromium.connectOverCDP(cdpUrl)`) to screenshot Mobbin pages —
  the MCP has no screenshot tool, so the CDP bridge is how we capture pixels.
- Remaining hurdle: Mobbin login-gates app screens; the cloud browser starts
  signed out, so it may need the founder's Mobbin login to see gated screens.
- Target URL: the Strava iOS app screens on Mobbin (activity detail stats,
  post-activity summary, weekly progress). Goal: map Strava's stat-tile
  hierarchy + effort visualization onto Toofies' activity screens.

## Highest-value next steps (only the founder can do)

1. Run a few Wave 0 interviews (`WAVE-0-INTERVIEW-KIT.md`).
2. Find an ED specialist to review the mechanic (`ED-REVIEW-BRIEF.md`).
3. First Xcode build on a Mac (the app has never compiled).

## Tooling notes

GSD installed in-repo (`.claude/`); plugin marketplaces + Playwright MCP in
`.claude/settings.json` / `.mcp.json`. Cross-model code review via Codex is a
required gate but runs locally (no Codex in the sandbox).
