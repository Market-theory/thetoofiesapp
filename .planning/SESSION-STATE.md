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
- Founder set network access to **Full**. Simple requests now work (`curl`
  reaches mobbin.com = 200). BUT **all browser pixel-capture paths are blocked
  by this environment's TLS-terminating proxy**, verified 2026-07-13:
  - Browserbase MCP (`navigate`/`extract`) works (routes via Anthropic), but
    has NO screenshot tool, and `extract` only reads DOM text — Mobbin screens
    are images, so it returns generic page text, not the Strava designs.
  - Playwright→Browserbase CDP bridge: the proxy won't carry the WebSocket
    (ECONNRESET); direct connect is egress-blocked.
  - Local Chromium in the sandbox via the proxy: `ERR_CONNECTION_RESET` — the
    proxy carries curl but resets browser traffic.
  - Plus Mobbin **login-gates** the screens; a signed-out browser sees a
    generic view regardless.
- **Conclusion: capturing Mobbin/Strava pixels is NOT possible from this
  cloud environment.** Reliable path = founder screenshots on their Mac (where
  they're logged into Mobbin) and drops the images into chat for analysis.
- We DO already have Strava's activity-screen *patterns* from public sources
  (see the chat / research): hero + big headline metrics, recessive secondary
  stat grid, splits, pace-over-elevation chart, 3-metric Lock Screen, and the
  "don't overcrowd" lesson. The activity-screen design can proceed on those
  without the Mobbin pixels.

## Highest-value next steps (only the founder can do)

1. Run a few Wave 0 interviews (`WAVE-0-INTERVIEW-KIT.md`).
2. Find an ED specialist to review the mechanic (`ED-REVIEW-BRIEF.md`).
3. First Xcode build on a Mac (the app has never compiled).

## Tooling notes

GSD installed in-repo (`.claude/`); plugin marketplaces + Playwright MCP in
`.claude/settings.json` / `.mcp.json`. Cross-model code review via Codex is a
required gate but runs locally (no Codex in the sandbox).
