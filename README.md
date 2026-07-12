# Toofies 🦷

An iOS dessert tracker that tracks your dessert intake, so you know exactly
when you can enjoy the sweet things in life.

## What it does

- **Treat check** — the answer the app leads with: "Go ahead! 🎉" or a live
  countdown to the moment your next treat unlocks.
- **Weekly budget** — set how many treats you get per week (default 5). Treats
  are paced evenly: with a budget of 5, one unlocks every ~33 hours after the
  last. The budget resets every Monday at midnight, local time.
- **One-tap logging** — cookie, cake, ice cream, chocolate, donut, candy, pie,
  cupcake — with haptic feedback.
- **Budget meter** — fill escalates from on-pace → getting close (≥70%) →
  spent (100%), always paired with an icon + label so state never rides on
  color alone.
- **Last-7-days chart** — treats per day (Swift Charts); tap a bar to see what
  you ate that day.
- **Stats** — treats left this week, 7-day daily average, and your streak of
  completed weeks on budget.

All data stays on-device (`UserDefaults`). Light and dark mode both supported.

## Requirements

- Xcode 16 or newer
- iOS 17.0+ deployment target

## Running it

1. Open `Toofies.xcodeproj` in Xcode.
2. Select the **Toofies** scheme and a simulator (or your device — set your
   development team under *Signing & Capabilities* first).
3. Run (⌘R).

The bundle identifier is `us.of-course.toofies`; change it if it collides with
your provisioning setup.

## Project layout

| Path | What's in it |
|---|---|
| `Toofies/ToofiesApp.swift` | App entry point |
| `Toofies/Models/` | `TreatStore` (state, persistence, budget pacing, stats) and data types |
| `Toofies/Views/` | One SwiftUI view per card: hero, meter, quick-log, tiles, chart, history, settings |
| `Toofies/Theme.swift` | Palette (validated for light/dark), duration formatting, card container |
| `prototype/web/index.html` | The original self-contained web prototype — same logic, runs in any browser |

## How pacing works

`TreatStore.nextTreatDate(now:)` is the whole product rule:

- Budget spent → next treat when the week resets (Monday 00:00).
- Nothing logged this week → go ahead now.
- Otherwise → last treat time + (week length ÷ budget), capped at the week
  reset.
