# Toofies — Real-User Validation Plan

**Why this exists:** the register's R5 — *nothing is validated with a real
user.* Before more building, answer two questions with real dessert-lovers:
1. **Demand:** do people actually want to track dessert recency / be more
   careful about consumption? (Is the core job real?)
2. **The economy question:** does the points economy make people open the app
   **more or less**, and feel **better or worse** — vs a plain recency tracker?
   (The council predicts *less/worse*; this test settles it, not opinion.)

This is designed to be cheap and fast. Do not build more until Wave 0 passes.

## Wave 0 — Demand & concept (this week, ~zero engineering)

**Method:** 6–10 qualitative interviews (~20 min each) + a concept test using
the existing simple prototype (`prototype/web/index.html`) or a quick clickable
mock. No new build required.

**Recruit (~8–10):** dessert-lovers, deliberately mixed:
- ~half "I just love dessert and want to be a bit more mindful" (the core user).
- ~half "I actively try to moderate sweets."
- Sources: personal network, local Orlando foodie/dessert groups, a dessert
  subreddit/Discord, friends-of-friends. Screen OUT anyone with a current or
  recent eating-disorder history (see ED-REVIEW-BRIEF.md — do not put this
  population in front of the economy).

**Ask (open, non-leading):**
- "Walk me through the last time you thought about whether to have a dessert."
- "Do you ever want to know how recently you last had one? Why / why not?"
- Show the recency idea (no points): does "X days since your last dessert /
  you're doing great" resonate or feel like nagging?
- Then show the points economy: does earning/spending points to have dessert
  feel *fun*, or does it feel like *restriction / guilt / a diet*? (Listen hard
  for guilt, "cheating," "bad," "earn it" language — those are red flags.)
- "Which version would you actually keep on your phone?"

**Success criteria (decide before you start, so you can't rationalize):**
- ≥6 of ~8 find the **recency/careful-consumption** idea genuinely useful
  unprompted. ← gates everything.
- The **recency version** is preferred by more people than the economy version,
  OR the economy clearly adds fun **without** triggering guilt/restriction
  language. If the economy triggers guilt talk, that's a stop-and-reshape
  signal, not a tweak.

## Wave 1 — In-use A/B (after Wave 0 passes + the "no-points" mode exists)

**Depends on** the ratified reshape (a recency-first build with a genuine
"just track recency, no points" mode — D2/D7–D9). Don't build this test rig
before Wave 0 justifies it.

**Method:** ~10 people, 2 weeks, via TestFlight. Split (or within-subjects,
crossover at week 1):
- **Arm A:** recency tracker only (no points).
- **Arm B:** recency tracker + the opt-in points economy.

**Measure:**
- Behavioral: days opened, logs made, retention through week 2, whether they
  turn the economy off (in Arm B).
- Experiential (short daily 1-tap check-in + end interview): did it help you
  feel more in control *without* feeling restricted? Any guilt? Would you keep it?
- **Safety signal (highest priority):** any language of guilt, punishment,
  compensation ("I have to walk it off"), or restriction. Any of this outweighs
  a positive engagement number.

**Decision it produces:**
- Economy nets positive (more opens, better feeling, no guilt) → keep it as the
  opt-in layer.
- Economy nets neutral/negative or triggers guilt → recency tracker is the
  product; economy stays off by default or is cut. (Council's predicted outcome.)

## Guardrails for the test itself
- The economy is only tested with users screened as **not** ED-vulnerable.
- Run the ED-specialist review (ED-REVIEW-BRIEF.md) **before** Wave 1, so the
  mechanic a real user touches has already been vetted.
- Keep it honest: pre-commit the success criteria above; don't move the
  goalposts to save the economy.
