# Toofies — Product Vision

## The founder's own words (2026-07-12)

> I love desserts… but I'm trying to be more healthy. I don't want to give up
> desserts entirely, but the goal is to be more responsible so I know when I
> had desserts most recently. In my mind, each day I don't eat dessert I get a
> certain amount of points, and after accumulating enough points, I can spend
> them by getting a dessert.

From the ideation transcript (Minutes AI, 2026-07-12):

> "We like the idea that you get a certain amount of points per day. We like
> the idea that if there's some kind of step tracker that's connected, you can
> earn points faster by just being more active. And then once you get a
> certain amount of points, you can spend them on your desserts. And then we
> want to find some way for them to have a daily check-in… something that
> incentivizes them to continuously do this."

> "Not really weight loss… ideally it incentivizes you to enjoy your dessert
> and have peace of mind that if you are doing other things, you're fine…
> make it a playful, fun thing… allows you to just enjoy your life."

> "I don't want to go too neutral about whatever your other intakes are. I
> want this to be fun — almost like a social media that's just about sharing
> your desserts."

## Core mechanic — the points economy

- **Earn (base):** every completed dessert-free day banks **+10 points**,
  credited at midnight.
- **Earn (activity):** with Apple Health connected, daily steps earn bonus
  points — **+1 pt per 1,500 steps, capped at +15/day** — credited at
  midnight *whether or not you had dessert that day* ("if I eat a dessert, I
  go for a walk — I'm even"; a 21k-step Disney day banks +14 on its own).
- **Spend:** a dessert costs points (default **30 ≈ 3 clean days**,
  adjustable 10–100). Points roll over — no weekly reset; save up for
  occasions.
- **Earn (daily quest):** a gamified step quest — walk a goal that adapts to
  your own recent week (105% of your 7-day median, 3k–12k) and bank a
  **+5 pt bonus** at midnight. Quest rotation/events are the designed answer
  to gamification's documented 3–4-week novelty decay.
- **Forgiveness:** logging is never blocked and there is no debt. An
  unaffordable dessert spends the balance to zero; earning resumes
  immediately. Honest logging beats punishment (see MARKET-RESEARCH.md §2).
- **Recency:** "when did I last have dessert" is a first-class surface —
  last-dessert date, days ago ("if you eat enough desserts, you won't
  remember either").
- **Streak = days on plan:** clean days AND fully-earned dessert days both
  count — enjoying a dessert you earned is the product promise and must never
  break the streak. Only an over-budget dessert pauses it (no debt, fresh
  start tomorrow). Milestones are dense through the first 10 days — the
  habit-formation window where drop-off risk falls (Duolingo evidence) —
  with 🦷 mascot celebration moments: 3, 7, 10, 14, 21, 30, 50…

## Gamification decisions (see research/DUOLINGO-GAMIFICATION.md)

| Mechanic | Decision |
|---|---|
| Evening streak-saver notification (streak-state-conditional, rotating templates, mascot-cheering never guilt) | v1.1 — with the daily check-in design pass |
| First-10-days habit ramp + milestone mascot moments | **v1 — implemented** |
| On-plan streak (out-forgives Duolingo's paid streak freeze by design) | **v1 — implemented** |
| Adaptive daily step quest (+5 bonus) | **v1 — implemented**; rotation/events v1.1 |
| Shared streak with a friend (Friend Streak analogue) | v2 — pairs with social dessert moments |
| Leagues/leaderboards, guilt copy, punitive streak loss | **Rejected** — dark-pattern territory, against framing rules |

## Decisions from the transcript

| Decision | Status |
|---|---|
| Activity (steps) earns points faster | **v1 — implemented** (HealthKit read-only, opt-in) |
| Daily check-in / continuous incentive | v1.1 — daily reminder notification + day-recap; design pass needed |
| Dessert-only focus — NOT a general intake/calorie tracker | **Locked.** Founder A explicitly rejected going "too neutral" |
| "Sneaky desserts" (soda, frappuccino, chips count) + intake quiz at onboarding | Parked. Fun angle but risks diluting dessert-only focus; revisit as an optional playful setting |
| Social dessert moments — Strava-style markers/photos, "I'm at Disney with my dessert" | v2 — sharing/feed is the long-term differentiator ("social media that's just about sharing your desserts") |
| Positioning: weight-**steady** / enjoy-your-life, never weight-loss | **Locked.** No calories, no weight, no diet language |

## Framing rules (from research + founder)

- You **earn** treats; the app never scolds. No calories, no weight, no
  "diet" language, no hard streak resets, no punitive lockouts.
- Peace of mind is the product: "am I safe to do this?" → yes/when.
- Playful tone (🦷 mascot, celebratory unlocks).

## Behavioral safeguards — LOCKED (ratified 2026-07-13, post-council)

The core ("being more careful about consumption") sits close to the
restriction/ED line. These are non-negotiable if any earn/spend food mechanic
ships. Rationale: `.planning/COUNCIL-2026-07-13.md` + MARKET-RESEARCH §2.

- **Never celebrate *abstinence* as the achievement.** Frame streaks/milestones
  around balance and enjoyment, not dessert-free days as a virtue score.
- **No "cost / afford / can't afford / spend" language around food**, and the
  score must **not visibly drop as a penalty** when a dessert is enjoyed.
- **Do not frame steps/activity as "paying for" dessert** (avoids installing
  exercise-as-penance).
- **Ship a "just track recency, no points" mode** — the economy is fully
  optional; the recency tracker is the safe core.
- **Signpost eating-disorder resources.**
- **Required gate:** a registered-dietitian / ED-specialist review of the
  mechanic before shipping any earn/spend food loop.
- The economy is an **opt-in experiment to validate**, not the assumed core.

## Positioning

A health/food app for dessert lovers: responsible indulgence via an
earn-your-treat points economy where **being active buys you sweetness**.
Differentiator vs CheatMate (logging only) and No Treat Today (interval
abstinence): the transparent earn/spend economy — clean days AND movement
both bank points, so desserts feel *deserved*, not rationed.
