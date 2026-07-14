# What Toofies Borrows — cross-app design synthesis

**Status: 🟡 REFERENCE / DIRECTION — un-ratified.** This distills the pixel-
verified reference library (`crumbl/`, `duolingo/`, `strava/`) into a
screen-by-screen direction for Toofies. It is **grounding for the design gate**,
not a set of decisions. Nothing here is a ratified visual/product choice — the
design skills + founder sign-off turn these candidates into a spec, and new
decisions get written into `DECISION-REGISTER.md` + `DESIGN-SPEC.md`.

Sources: founder-pulled Mobbin captures of **Crumbl** (dessert peer), **Duolingo**
(habit/economy/mascot), **Strava** (health/streak/gamification/privacy).

---

## 1. The through-line (what all three converge on)

- **Quiet shell + reserved accent(s).** Crumbl = near-mono + pink for delight
  only. Strava = mono + **orange (act) / gold (achieve) / green (complete)**.
  Both keep chrome calm and spend color on *joy and progress*.
- **Big, confident type; one clear action per screen.** Oversized bold titles,
  a small gray eyebrow above, generous whitespace, a single primary button.
- **Celebrate the person's progress, loudly.** Streaks, badges, completion
  moments, warm empty states — momentum is the product.
- **An earn → threshold → reward loop** makes progress tangible (Crumbl crumbs,
  Duolingo gems).
- **Private-by-default, opt-in everything.** Strava's per-item visibility + safety
  tools are the model for the founder's data/location concerns.

**Candidate Toofies design language (un-ratified):** a restrained, premium shell
(quiet neutrals), **one warm accent reserved for celebration**, plus a possible
second "achievement" accent; big rounded type; the **treat (emoji/photo) as the
one spot of appetite/color**; playful but never punitive voice.

---

## 2. Screen-by-screen map (borrowed → Toofies)

### Home — "Am I safe to have a dessert?" + your streak
- **From Strava:** the **"Your streak" widget** (flame + week-row of circles,
  completed days filled, Share button) → **days-on-plan streak** as the home
  centerpiece (shoe → 🦷). Include the warm **0-week empty state**.
- **From Strava/Crumbl:** a **progress-toward-reward bar** ("points toward your
  next dessert") — Crumbl's "0/100 · 100 more" + Strava's goal rings.
- **From Crumbl:** recency as a calm hero line ("It's been N days since your last
  dessert") — the treat/emoji as the one warm visual.
- **Reuse our own scaffold:** the current `src/app/index.tsx` already renders
  recency + availability + streak; this is the design of *that*, not new logic.

### Logging a dessert — the rewarded reflection loop ⭐
- **From Crumbl:** after logging → **emoji sentiment + optional photo of the
  treat + a small "+earned" celebration**. Makes logging feel *warm and
  celebrated*, never a guilty confession. This is the single most on-strategy
  borrow.
- **Voice:** pro-dessert, guilt-free (Crumbl's indulgence-as-joy tone).

### Streak, milestones & celebration
- **From Strava:** the **locked/unlocked milestone badge ladder** (Trophy Case)
  → our streak milestones (3/7/10/14/21/30…) as a **collectible ladder** with
  visible future goals + a satisfying "earned" state.
- **From Duolingo + Strava:** a **full-screen celebration moment** (confetti /
  big badge / "Share achievement") for milestones → the **Sweet Toofies** beat
  ("your Sweet Toofies are proud of you").

### The points economy (opt-in experiment, D7–D9)
- **From Crumbl (crumbs→cash) + Duolingo (gems shop):** the **earn → threshold →
  reward** loop, a visible **balance card**, and **`+X` reward chips** on a
  "ways to earn" list.
- **Inversion (safeguard):** Crumbl/Duolingo reward *doing more*; Toofies rewards
  **clean days + movement**. Keep the satisfying loop; flip the trigger. Must
  also work with the economy **off** (the "just track recency" mode).

### Steps / activity (Apple Health)
- **From Strava:** the **2-column stat grid** (label over big value), the
  **weekly-trend chart**, and glanceable big-number views → Toofies steps/points
  tiles + a "steps this week" chart. Frame movement as *adding to your day*,
  **never** "earning the right to eat."

### Onboarding
- **From Strava/Duolingo:** **question-first, motivation-first** ("why are you
  here?" → be mindful / build a habit / just track recency), then a **gamified
  0/4 checklist** (log first dessert, pick your mode, connect Health…), warm
  bookends ("Welcome"), minimal + reason-explained fields.
- **From Strava:** a **privacy screen inside onboarding** ("private by default,
  you control everything").

### Profile / stats
- **From Strava:** the **You/Progress** hub — a headline **streak stat**, a
  **weekly-trend chart**, tiered **statistics** (week/YTD/all-time), and a
  **Trophy Case** gallery of earned Sweet-Toofies milestones.

### Privacy (the headline takeaway)
- **From Strava:** **private-by-default**, per-item visibility with plain-language
  consequences, ability to hide specific metrics, opt-in **Beacon**-style safety
  sharing (capped, explicit consent). **Invert Strava's one bad default:** their
  *profile* is public-by-default — Toofies should be **private-by-default
  everywhere.** This is the concrete answer to "isn't that data collection?"

### Social & discovery (LONG-TERM, opt-in — deferred)
- **From Strava:** kudos/comments (encouragement, not ranking), the **safety
  toolkit** (mute/block/anonymous-report), friend discovery (QR/contacts), and
  the **routes/discovery** map + filter chips → the eventual dessert-place
  discovery. All **opt-in, non-coercive, safeguarded**; none default-on.

---

## 3. The reject list (locked behavioral safeguards — do NOT borrow)

- ❌ **Consumption-driving mechanics** — Crumbl's scarcity/FOMO, buy-more push,
  craving-trigger imagery used to *prompt* eating.
- ❌ **Coercive gamification** — Duolingo's guilt/shame notifications,
  streak-loss anxiety, loss-aversion.
- ❌ **Competition by default** — Strava's leaderboards/segments as a default;
  any competition is strictly opt-in, never ranking users automatically.
- ❌ **Compensatory framing** — steps as "paying for" dessert; score dropping as
  a penalty; any calorie/weight/diet language.
- ❌ **Public-by-default anything.**

---

## 4. Open design decisions this surfaces (for DECISION-REGISTER)

These are the questions the design gate must answer (all 🔴 OPEN):
1. Palette — the quiet shell neutrals + the warm celebration accent (and a
   possible 2nd "achievement" accent). Crumbl(mono+pink)/Strava(mono+orange/gold/
   green) are *references*, not our colors.
2. Typography — the big-bold-rounded direction (Duolingo-ish) vs. editorial
   (Crumbl-ish).
3. Home layout — recency-first vs. streak-first vs. "am I safe?"-first.
4. Streak/milestone visual system (flame? teeth? badge shape?).
5. Whether the economy is visible by default or opt-in-on-top-of-recency.
6. Mascot form — how "Sweet Toofies" (plural teeth 🦷) actually render.

---

## 5. How this feeds the design gate

Per the constitution: a **design pass** (invoke `ui-ux-pro-max` / `frontend-design`)
grounded in **this doc + `DESIGN-SPEC.md`** produces *options* for the founder to
choose; ratified choices go into `DECISION-REGISTER.md` + `DESIGN-SPEC.md`; then
the build wave; then a `design-review` pass. This synthesis is the input, not the
verdict.
