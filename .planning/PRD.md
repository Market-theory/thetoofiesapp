# Toofies — Product Requirements Document (PRD)

**Status:** v1 scope. Living document.
**Owner:** founder (all material decisions). Author: Claude Code.
**Source of truth precedence:** `DECISION-REGISTER.md` → `PRODUCT.md` →
`DESIGN-SPEC.md` → `research/*`. On any conflict, the Decision Register wins.

> This PRD describes **what Toofies v1 is and why**. It encodes only what is
> 🟢 RATIFIED and flags everything still 🔴 OPEN. It makes **no** visual,
> economic-value, or architectural decisions of its own — those belong to the
> founder via the Decision Register. Where a number or default appears (e.g. the
> point values), it is a **labeled placeholder**, not a settled choice.

---

## 1. Problem & one-line vision

**Vision:** A playful, guilt-free way for dessert lovers to be *mindful* about
dessert — know when they last had one, feel at peace about having one now, and
(optionally) earn treats by living well — with **zero** diet, calorie, or weight
framing.

**Problem (founder's words):** "I love desserts but I'm trying to be more
healthy. I don't want to give them up — I want to be responsible, know when I
last had dessert, and feel fine enjoying one." Existing tools either just log
(no motivation) or ration by abstinence intervals (feels punitive). Nothing
makes responsible indulgence feel *earned and celebrated* instead of restricted.

**The single job of v1:** answer "**when did I last have a dessert, and am I in a
good place to have one now?**" — calmly, playfully, on-device.

---

## 2. Positioning (🟢 RATIFIED — D1)

- Toofies is **primarily about careful, guilt-free consumption** — a mindful
  tracker with recency as the hero surface.
- Social sharing of favorite desserts/places is a **secondary, later** layer
  (v2+), never the v1 core.
- **Never** a diet / calorie / weight-loss app. Positioning is
  weight-**steady**, enjoy-your-life.
- Differentiator: a transparent **earn-your-treat** idea where clean days *and*
  movement both contribute — desserts feel *deserved*, not rationed — offered as
  an **opt-in experiment**, layered on top of a safe recency core.

---

## 3. Users

Two personas surfaced in ideation (D1). They align on **tone** (anti-restriction,
playful) and differ on **hook**:

- **Persona A — "responsible indulgence":** health-conscious dessert lover who
  wants peace of mind ("am I okay to have this?"), likes spacing treats out, and
  finds it fun — even a little social.
- **Persona B — "recovered-from-restriction":** explicitly anti-diet,
  anti-calorie; desserts are normal food; the app must **never** feel restrictive
  or moralizing.

**Design implication:** Persona B is the guardrail. If a feature would make
Persona B feel policed, it violates the framing rules. The behavioral safeguards
(§6) exist because "careful about consumption" sits closest to the
restriction/ED line.

---

## 4. v1 scope (🟢 RATIFIED — D2, D4)

**v1 IS:** a **solo, on-device** dessert tracker centered on the
**careful-consumption / recency** job, with:

- Recency tracking (the safe core — works with everything else off).
- An **opt-in** points economy *experiment* (earn/spend + streak + step quest),
  clearly optional and validated before it's ever made the default.
- On-device persistence only. **No accounts, no social, no backend, no paywall.**

**v1 IS NOT:** accounts, cloud sync, social/feed, friends, location, dessert-place
discovery, or any national directory. All of that is captured (D22–D26) and
explicitly deferred to later versions.

**Two modes, one app (the safeguard that shapes the whole product):**

| Mode | What it shows | Status |
|---|---|---|
| **Recency-only (safe core)** | Last-dessert date, days since, simple history. No points, no streak, no "am I safe" economy. | **Must ship. This is the validated-safe baseline** and the default until the economy is proven. |
| **Economy (opt-in experiment)** | Adds points earn/spend, on-plan streak, milestones, step quest. | Opt-in only; behind the safeguards (§6); gated by ED review (§9). |

> ⚠️ **Known deviation / reshape (from DECISION-REGISTER):** the *current* build
> leads with the economy, celebrates dessert-free "days on plan," and uses
> "cost / afford / spend" copy + steps-as-payment. That contradicts the ratified
> direction and the locked safeguards. v1 work is a **deliberate reshape** to
> recency-first + economy-behind-a-toggle with safeguard-compliant framing — not
> a silent continuation of the current scaffold. See the Agent Build Spec.

---

## 5. Core mechanic — the points economy (🟡 built, values are placeholders — D7–D9)

The engine is **ported and verified** (`src/lib/economy.ts`); the **numbers are
placeholders** the founder has not ratified (D7). Presentation is constrained by
the safeguards (§6).

- **Earn (base):** every completed dessert-free day banks **+10 pts** *(placeholder)*
  at local midnight.
- **Earn (activity):** with Apple Health connected (opt-in, read-only), **+1 pt
  per 1,500 steps, capped +15/day** *(placeholder)*, credited at midnight whether
  or not dessert was had that day.
- **Earn (daily quest):** an adaptive step goal (105% of your 7-day median,
  clamped 3k–12k) banks a **+5 pt** *(placeholder)* bonus at midnight. Quest
  rotation/events are the planned answer to the ~3–4-week novelty decay
  (v1.1).
- **Spend:** a dessert draws down points; default **30 pts ≈ 3 clean days**
  *(placeholder; adjustable 10–100)*. Points roll over — no weekly reset.
- **Forgiveness (LOCKED framing):** logging is **never** blocked; there is **no
  debt.** An over-budget dessert draws the balance to zero and earning resumes
  immediately.
- **Streak = days on plan (🔴 needs ratify — D9):** clean days **and**
  fully-earned dessert days both count; only an over-budget dessert pauses it
  (no reset spiral — fresh start next day). Milestones dense through the first 10
  days (habit-formation window): 3, 7, 10, 14, 21, 30, 50… with 🦷 celebration
  moments.
- **Recency (first-class, mode-independent):** last-dessert date + days-ago,
  shown even with the economy off.

**Open economic decisions:** D7 (exact values / onboarding-quiz tuning),
D8 (steps-only vs workouts/energy), D9 (confirm streak semantics).

---

## 6. Behavioral safeguards — LOCKED, non-negotiable (🟢 RATIFIED)

These bind **any** shipped earn/spend food mechanic. Rationale:
`COUNCIL-2026-07-13.md` + `research/MARKET-RESEARCH.md §2`.

1. **Never celebrate *abstinence* as the achievement.** Frame streaks/milestones
   around balance and enjoyment — not dessert-free days as a virtue score.
2. **No "cost / afford / can't afford / spend" language around food**, and the
   score must **not visibly drop as a penalty** when a dessert is enjoyed.
3. **Never frame steps/activity as "paying for" dessert** (no
   exercise-as-penance).
4. **Ship a "just track recency, no points" mode** — the economy is fully
   optional; recency is the safe core.
5. **Signpost eating-disorder resources** in-app.
6. **The economy is an opt-in *experiment to validate*,** not the assumed core —
   validated against a no-economy recency tracker with real users before it is
   ever made default.

> **Tension to reckon with (do not paper over):** an earn/spend loop, by
> definition, moves a balance up and down. Safeguard #2 says the score must not
> read as a *penalty* on enjoyment. Reconciling "an economy exists" with "spending
> never feels punitive" is a **core design problem** for the design gate — not a
> copy tweak. The recency-only mode and the ED-review gate exist precisely
> because this tension is real and unresolved.

---

## 7. Feature requirements (v1)

Priorities: **P0** = required to ship v1 · **P1** = v1 if time · **P2** = v1.1+.

| # | Requirement | Priority | Decision status |
|---|---|---|---|
| F1 | **Recency-only safe core**: last-dessert date, days-since, log a dessert, simple history. Works fully with the economy off. | **P0** | 🟢 (D2, safeguard #4) |
| F2 | **Log a dessert** from a dessert set; entry timestamped + persisted on-device. | **P0** | 🟢 mechanic; 🔴 dessert set (D6) |
| F3 | **On-device persistence** (AsyncStorage), survives relaunch; export/reset. | **P0** | 🟢 (D4) |
| F4 | **Economy mode (opt-in)**: earn/spend, streak, milestones, quest — behind an explicit toggle, safeguard-compliant framing. | **P0 (as opt-in)** | 🟡 built; framing 🔴 |
| F5 | **Apple Health steps** (opt-in, read-only) → activity points. | **P1** | 🟡 built logic; native module 🔴 |
| F6 | **Milestone celebration** moments (🦷). | **P1** | 🟡 logic built; visual 🔴 (design gate) |
| F7 | **ED-resource signposting** surface. | **P0** | 🟢 (safeguard #5) |
| F8 | **Home/Lock-Screen widget** (research's #1-ranked feature). | **P1** | 🔴 (D17) |
| F9 | **Gentle daily check-in / streak-saver notification** (opt-in, never guilt). | **P2** | 🔴 (D18) → v1.1 |
| F10 | **Settings**: economy on/off, dessert cost, Health connect, reset/export, resources. | **P0** | 🟡 (depends on open values) |
| F11 | Custom dessert items / "sneaky desserts" toggle. | **P2** | 🔴 (D6) |
| F12 | Social / friends / location / discovery. | **P2 (v2+)** | 🔴 (D22–D26) — out of v1 |

---

## 8. Non-goals for v1 (explicit)

- No accounts, login, or cloud sync (D4 = on-device).
- No social feed, friends, kudos, or shared streaks (D22 → v2).
- No location sharing or check-ins (D23 → v2, highest safety sensitivity).
- No dessert-place discovery or directory (D24–D26 → v2/v3, possibly its own
  product; see risks R3–R4).
- No paywall / subscription (D10 → revisit v2).
- No calorie, macro, weight, or diet tracking — **ever**.

---

## 9. Constraints & gates

- **Platform (🔴 D16):** Rec iPhone-only for v1 (cuts iPad QA). Not ratified.
- **Stack (🟢 D27):** Expo / React Native (TypeScript). Web + Expo Go previewable
  from the cloud (no Mac/Xcode dependency for dev).
- **Privacy (🟢 D4):** "Data Not Collected." No network calls carrying user data
  in v1. Apple Health is read-only, opt-in, on-device.
- **Design (🔴 D11–D15):** **nothing decided.** No colors/type/mascot/layout may
  be applied without founder sign-off through the design gate. The current look
  is un-styled scaffolding, not an approved design.
- **🚦 SHIP GATE — ED-specialist review (🟢 required):** a registered-dietitian /
  eating-disorder-specialist review of the mechanic is **required before shipping
  any earn/spend food loop.** The recency-only core can proceed to build/preview;
  the economy cannot ship to real users until this gate clears.
- **Code-review gate (constitution §4):** nontrivial code gets Claude
  `/code-review` + `/security-review`; a **cross-model Codex pass is owed locally**
  (not available in the cloud container — flag it, don't skip it).
- **Ambition (🔴 D3):** personal tool vs TestFlight beta vs public launch is
  undecided — it sets the quality bar and how much of App Store submission
  applies now.

---

## 10. Success & validation (🟡 — ties to D3, R5)

**Nothing is validated with a real user yet (R5).** The highest-value early
signal is not more building — it is putting the **recency core** (and, separately,
the opt-in economy) in front of real people and learning which they actually want.

Candidate v1 success signals (to ratify with D3):

- A real user tracks recency for ≥1 week unprompted (core-job pull).
- Among economy opt-ins: the loop is used without it reading as restrictive
  (Persona-B safe) — measured by continued voluntary use + qualitative check-ins,
  **never** by celebrating abstinence streaks as the win.
- Economy-on vs recency-only comparison informs whether the economy becomes core
  (D7–D9 experiment).

---

## 11. Open decisions blocking full v1 (from DECISION-REGISTER)

Must be ratified by the founder — the build spec **stops** at each:

- **D3** ambition/quality bar · **D6** dessert set · **D7** point values ·
  **D8** activity sources · **D9** streak semantics · **D10** monetization ·
  **D11–D15** all design · **D16** iPhone-only · **D17** widget in v1 ·
  **D18** notifications · **D19** name-final · **D21** launch plan.

---

## 12. Risks & tensions (maintained — see DECISION-REGISTER §Risks)

- **R1 Scope creep** is the live risk (tracker → national platform in one
  session, nothing validated). Discipline: pick the wedge (recency core), ship,
  learn.
- **R2** "tracker is a wedge into discovery" is unproven.
- **R5** nothing validated with a real user — validation may beat building.
- **R6** privacy-as-a-feature vs the social/location vision directly conflict.
- **Economy-vs-safeguard tension** (§6) — the central product-design problem.
