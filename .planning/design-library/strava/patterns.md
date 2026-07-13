# Strava — Activity/Health Screen Patterns (reference)

**Source note:** gathered from **public** descriptions, not Mobbin pixels
(Mobbin was unreachable from the cloud env — see SESSION-STATE.md). Sources:
Strava's own [Activity Page guide](https://stories.strava.com/articles/strava-guide-your-activity-page-101)
and [Run Activity Pages support](https://support.strava.com/en-us/articles/15401883-run-activity-pages),
[Page Flows – Strava](https://pageflows.com/screens/mobile/product/strava/),
[Strava Live Activities (iOS)](https://support.strava.com/en-us/articles/15401559-strava-live-activities-on-ios),
and community feedback on the 2025 redesign
([1](https://communityhub.strava.com/strava-features-chat-5/new-activity-layout-is-atrocious-9870)).
**Refine against real screenshots when available.**

## The activity-summary screen — anatomy (top → bottom)

1. **Hero: map + 3 headline metrics.** The activity opens with the route map
   and the three numbers that matter most — **time, distance, pace** — large
   and first. (Live Activities show these same three on the Lock Screen.)
2. **Secondary stat grid.** Elevation, cadence, calories, heart rate, etc. as
   smaller, recessive tiles below the hero. What shows depends on space — the
   headline three get priority; extras yield.
3. **Splits list.** Per-mile/km rows with basic info each — progressive detail
   for those who want it.
4. **Pace-over-elevation chart.** Real-time pace overlaid on the elevation
   profile; **darker bars = faster, lighter = easier.** Grade-Adjusted Pace
   normalizes for hills. This is how effort-over-time is visualized.
5. **Photos, then social.** Media, then kudos + comments at the bottom.

## The principles worth stealing

- **Hierarchy is everything:** 2–3 numbers dominate; everything else recedes.
- **Progressive disclosure:** headline metrics up top, charts/splits below.
- **Effort visualized over time**, not just totaled — the pace/elevation chart
  makes the activity feel like a story, not a number.
- **Completion feels like an event** — finishing an activity is a moment, not
  a silent save.
- **Lock Screen = exactly 3 metrics.** Ruthless prioritization when space is
  tiny.

## Anti-pattern (their own misstep)

The 2025 redesign was widely criticized for **cramming map + stats + photos
onto one crowded page** ([community thread](https://communityhub.strava.com/strava-features-chat-5/new-activity-layout-is-atrocious-9870)).
Lesson for Toofies: keep the activity view **focused** — a few meaningful
numbers, not everything at once.

## How this maps to Toofies' activity/health screen

*(Design is un-ratified — this is a proposed mapping to react to, not decided.)*

| Strava pattern | Toofies equivalent |
|---|---|
| Hero: time / distance / pace | **Hero: steps today + points banked** (2 big numbers, first) |
| Secondary stat grid | Quest progress + days-on-plan streak as recessive tiles |
| Pace-over-elevation chart | **Steps-over-the-week trend** — movement accumulating toward the next treat |
| Completion is an event | **"Quest complete / activity banked"** celebration moment |
| Lock Screen = 3 metrics | Widget / Live Activity: steps · points today · balance |
| "Don't overcrowd" lesson | Keep Toofies' activity card to a few meaningful numbers |

Behavioral-safeguard check (per PRODUCT.md): frame activity as *movement that
adds to your day*, never as "earning the right to eat" — steps contribute
points, but the copy stays celebratory of movement, not compensatory.
