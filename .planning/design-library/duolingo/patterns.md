# Duolingo — Gamification & Celebration Patterns (reference)

**Category:** Habit / gamification (the category's gold standard). Duolingo is
the reference for **streaks, an earn-and-spend economy, milestone celebration,
and a beloved mascot** — the exact surfaces Toofies' points/streak/Sweet-Toofies
mechanics need to nail. It is also the industry's most famous source of
*manipulative* engagement patterns, so it doubles as our clearest catalog of
what to **avoid** (critical given Toofies' ED-informed safeguards).

**Source note:** knowledge- and public-source-based, **not** Mobbin pixels
(Mobbin login-gated from cloud, 403 verified 2026-07-14). Exact Mobbin screen
URL recorded in `screens/SOURCE.md` for a local pixel pull. **Refine against
real screenshots when available.**

## The flows worth studying

1. **Onboarding (question-first, signup-last).** Asks *why* you're here and sets
   a daily goal **before** any account creation — commitment before friction.
   Ends on a notification opt-in framed around the goal.
2. **Home path.** A single, playful winding "path" of bite-sized lessons; one
   obvious next action; the start button subtly bounces to invite the tap.
3. **Streak.** A flame + day count is a top-level, always-visible badge. A
   **calendar** shows the streak history; **streak freeze** protects a missed
   day; milestone days get their own full-screen celebration.
4. **Lesson-complete celebration.** Confetti, sound, big numbers, an XP tally,
   and an expressive Duo moment — **finishing is an event**, richly rewarded.
5. **Earn-and-spend economy (gems).** You earn gems from progress and spend them
   in a shop (e.g. streak freezes, outfits). **This is a direct structural
   parallel to Toofies' points** — earn from good days/steps, spend on desserts.
6. **Leagues / leaderboards.** Weekly competitive tiers (optional social layer).

## The principles worth stealing

- **Celebrate completion loudly.** A finished action deserves confetti, a big
  number, and a mascot beat — the dopamine of *done*. → Toofies streak/quest
  milestone moments ("your Sweet Toofies are proud of you").
- **Streak as an always-visible, emotionally-loaded token.** The flame + count
  is instantly legible and worth protecting.
- **A forgiving safety valve.** The **streak freeze** is the humane part of
  Duolingo's streak design — it prevents one bad day from erasing everything.
  Toofies goes further (no hard resets, no debt) but the *spirit* is shared.
- **Earn-and-spend economy makes progress tangible.** Points you can *do*
  something with beat abstract scores. Directly validates the Toofies economy's
  structure (an opt-in experiment, D7–D9).
- **Question-first onboarding.** Motivation and goal before signup lifts
  activation — informs a Toofies day-1 flow.
- **A mascot carries the emotion.** Duo makes the app feel alive. → the plural
  **Sweet Toofies** (the user's own teeth) as the emotional messenger.

## Anti-patterns — what Toofies must NOT copy (LOCKED safeguards)

Duolingo is the textbook case of engagement turning coercive. Given Toofies'
ED-informed safeguards, these are hard NOs:

- **Guilt-trip / shaming notifications** ("You made Duo sad"). Toofies nudges
  are warm and pressure-free — never manipulative, never shaming.
- **Streak-loss anxiety as a retention lever.** Weaponizing fear of losing a
  streak is exactly the pressure our forgiving-by-design model rejects (no hard
  resets, no debt).
- **Loss-aversion dark patterns** (dangling then threatening to remove
  progress). Toofies never punishes; the score must never drop as a penalty.
- **Endless competitive pressure** (leagues that induce compulsion). Any social
  layer stays opt-in and non-coercive.

## → Toofies mapping

*(Design is un-ratified — a proposed mapping to react to, not decided.)*

| Duolingo pattern | Toofies equivalent |
|---|---|
| Flame + day count badge | **Days-on-plan streak**, always visible, emotionally legible |
| Streak freeze (forgiving valve) | Toofies' no-reset / no-debt forgiveness (goes further) |
| Lesson-complete confetti moment | **Milestone / quest-complete celebration** with Sweet Toofies |
| Gems earn-and-spend shop | **Points economy** — earn from clean days + steps, spend on desserts |
| Duo the mascot carries emotion | **Sweet Toofies** (plural — the user's own teeth 🦷) |
| Question-first onboarding | Toofies day-1: motivation + goal before any signup |
| Guilt/shame/loss-aversion levers | **Explicitly rejected** — LOCKED behavioral safeguards |

**Behavioral-safeguard check (PRODUCT.md):** take Duolingo's *joy of
completion and tangible progress*; leave every coercive, shaming, or
loss-aversion mechanic behind. Forgiving, never punitive.
