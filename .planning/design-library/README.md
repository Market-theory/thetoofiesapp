# Toofies — Design Reference Library

A curated database of **successful app designs, flows, and UI** we reference
when designing Toofies — so every screen is grounded in what proven apps do,
not invented from scratch. Reuse-before-invent.

## How an entry is structured

Each app lives in its own folder: `design-library/<app>/`

```
design-library/
  <app>/
    patterns.md     ← the analysis: flows, UI patterns, principles, Toofies mapping
    screens/        ← the actual reference screenshots (the source material)
```

`patterns.md` for each app captures: **category**, the **flows** covered
(onboarding, activity, logging, progress, paywall, social…), the **UI patterns
worth stealing**, any **anti-patterns**, and an explicit **→ Toofies mapping**
(which Toofies screen each pattern informs).

## How references get INTO the library (the pipeline)

**Screenshots are the input.** Drop app screenshots into the chat (or into the
right `screens/` folder) and I catalog each one: I identify the flow, break down
the UI patterns, note what's worth reusing, and write it into that app's
`patterns.md` with a Toofies mapping. Batches are welcome — dump a whole flow at
once.

> **On automated pulling (e.g. Mobbin):** it is **not possible from this cloud
> environment** — Mobbin's screens are login-gated and the browser tool wired
> into this session has no screenshot capability (verified 2026-07-13; see
> SESSION-STATE.md). So for now the library is seeded by screenshots. Automated
> pull becomes possible only with a screenshot-capable browser tool that's
> logged into Mobbin — a tooling change for a future session, not a blocker on
> building the library today.

## Master index

| App | Category | Flows to capture | Patterns analysed | Screens |
|---|---|---|---|---|
| **Strava** | Activity / Fitness | activity detail, post-activity summary, weekly progress, (social) | ✅ `strava/patterns.md` | ⏳ pending — drop into `strava/screens/` |
| _Finch_ | Self-care / mascot | onboarding, home, celebration | ⏳ | ⏳ |
| _Duolingo_ | Habit / gamification | streak, milestone, day-1 onboarding | ⏳ | ⏳ |
| _Streaks / Gentler Streak_ | Habit / streaks | streak visual, widget, watch | ⏳ | ⏳ |
| _Beli_ | Social food discovery | ranked lists, friends, discovery | ⏳ | ⏳ |
| _Cal AI_ | Nutrition / AI | onboarding, paywall | ⏳ | ⏳ |

*(Rows in italics are the shortlist from our research — add screenshots to
promote them from ⏳ to analysed.)*

## Why these apps

Chosen from the market, features, and gamification research (`.planning/
research/`): mascot/emotional design (Finch), streak & celebration mechanics
(Duolingo, Streaks), forgiving progress (Gentler Streak), activity/effort UI
(Strava), social food discovery (Beli), and onboarding/paywall polish (Cal AI)
— the exact surfaces Toofies needs to nail.
