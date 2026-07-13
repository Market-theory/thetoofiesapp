# Toofies — Decision Register

**Purpose:** the single source of truth for every material decision. Nothing
gets built without a **ratified** decision here. Each entry carries the context
needed to decide well — no decision is "skipped past."

**Legend:** 🔴 OPEN (undecided) · 🟡 PROPOSED (my rec, awaiting your ratify) ·
🟢 RATIFIED (you decided) · ⚪️ DEFERRED (revisit later).
"Blocks" = other decisions that can't be settled until this one is.

> Operating rule going forward: I surface the decision + context + options + a
> recommendation. **You decide.** I don't apply a choice — visual, structural,
> or architectural — until it's 🟢 here.

---

## 🟢 RATIFIED 2026-07-13 ("agreed on all fronts")

The founder ratified the post-council direction. Now locked:

- **D1 · Positioning:** the app is **primarily about careful, guilt-free
  consumption** (the tracker + recency answer). Social sharing of favorite
  desserts/locations is a **secondary** layer. Never a diet/calorie/weight app.
- **D2 · v1 core:** a **solo, on-device, careful-consumption + recency
  tracker**. No accounts, no social, no paywall in v1.
- **D4 (v1):** **on-device only** for v1 ("Data Not Collected").
- **D7–D9 · Points economy = an OPT-IN EXPERIMENT, not the foundation.** Must
  be validated against a no-economy recency tracker with real users before it
  is ever made core. Ship a "just track recency, no points" mode.
- **Behavioral safeguards = LOCKED (non-negotiable if any earn/spend food
  mechanic ships):** never celebrate *abstinence* as the achievement; no
  "cost/afford/can't afford/spend" language around food; the score must not
  visibly drop as a penalty when a dessert is enjoyed; don't frame steps as
  "paying for" dessert; ED-resource signposting. (Mirrored into PRODUCT.md.)
- **ED-specialist review = REQUIRED GATE** before shipping any earn/spend food
  mechanic (registered dietitian / eating-disorder specialist).
- **D27 · Tech stack = Expo / React Native (TypeScript)** — founder directive
  2026-07-13 (`npx create-expo-app toofies`). Supersedes the native SwiftUI
  build. **Why it's a good call:** Expo runs on web + Expo Go, so the app is
  **buildable and previewable in the cloud** (and on your phone) with no
  Mac/Xcode dependency — the exact blocker that stalled the SwiftUI app.
  **Carries over unchanged:** the points economy, recency, streak, and all
  behavioral safeguards (stack-agnostic logic), plus PRODUCT/VISION/research/
  design-library. **Now needs porting/updating:** the SwiftUI code → RN (or
  archive it as reference); HealthKit → an Expo health module/config plugin;
  `APP-STORE-SUBMISSION.md` → EAS Build flow; `DEV-SETUP.md` → Expo dev (much
  simpler — Expo Go, no Xcode for dev). **Open:** archive the SwiftUI app or
  keep it as reference? (Recommend archive to `native-swiftui/` — it's a
  reference, not a parallel product.)

**⚠️ The current build deviates from this ratified direction** (it leads with
the economy, the streak celebrates dessert-free "days on plan", and copy uses
"cost/afford/spend" + steps-as-payment). These are now tracked **reshape
items** — to be sequenced deliberately, NOT silently rebuilt. See "Next" below.

**Still OPEN (not covered by this ratification):** D3 (indie vs venture
ambition), D6 (custom dessert list), D10 (monetization), D11–D15 (all design),
D16 (iPhone-only), D17 (widget in v1), D18 (notifications), D19–D21 (name,
pricing, launch), D22–D26 (social/location/discovery specifics — deferred to
later layers).

## Tier 0 — Product definition (blocks almost everything)

### D1 · Primary user & positioning 🔴  — *blocks D2, D10, D11–15, D19*
The ideation transcript held an unresolved tension:
- **Persona A ("responsible indulgence"):** health-conscious dessert lover who
  wants peace of mind — "am I safe to have this?", spacing treats out, knowing
  recency. Wants it *fun*, even social.
- **Persona B ("recovered-from-restriction"):** explicitly anti-diet,
  anti-calorie; desserts are normal; the app must never feel restrictive.
The market research says the *anti-restriction, playful* framing is the
defensible, growing niche. These personas mostly align on tone but differ on
whether the hook is "control/peace-of-mind" vs "guilt-free enjoyment."
**Founder steer (2026-07-13):** *"mostly this app is about being more careful
about consumption"* — with social sharing of favorite desserts/locations as a
**secondary** layer. This settles the core: the primary job is **mindful/
careful consumption** (the tracker + recency), not discovery. **Rec (🟡):**
positioning = careful, guilt-free consumption; sharing secondary. **Note the
tension the behavioral council flagged:** "careful about consumption" sits
closest to the restriction/ED line — so this framing is exactly the one that
needs the behavioral safeguards (see COUNCIL-2026-07-13.md). **Confirm to ratify.**

### D2 · What v1 *is* — scope boundary 🔴  — *blocks everything downstream*
The minimum lovable v1. Candidate line: solo, on-device dessert + activity
tracker centered on the **careful-consumption / recency** job, with the
earn/spend economy as an **opt-in experiment** (per the council, not the
foundation), streak, and quest — **no accounts, no social, no paywall.**
Social sharing of favorite desserts/locations = a deliberate later layer (D22).
**Rec (🟡):** yes to that boundary; validate the economy with real users before
making it core. **Needs ratify.**

### D3 · Ambition & success definition for v1 🔴
Is v1: (a) a personal tool for you, (b) a soft TestFlight/beta launch, or (c) a
full public App Store launch? This sets the quality bar, timeline, and how much
of the submission guide applies now.

---

## Tier 1 — Architecture & data

### D4 · Accounts vs on-device 🔴  — *blocks D5, privacy label, backend cost*
The fork from the last discussion. On-device = "Data Not Collected," zero legal
surface, no backend. Accounts = enables social/sync, but GDPR/CCPA, in-app
account deletion, secure backend, breach liability. **Rec (🟡):** on-device for
v1; accounts as a deliberate v2 with its own privacy workstream. **Needs ratify.**

### D5 · Backend / cloud sync 🔴 — depends on D4
None (v1 on-device) vs a backend (accounts, multi-device, social). Follows D4.

### D6 · What counts as a "dessert" 🔴
Fixed emoji set (current) · user-customizable list · or the transcript's
"sneaky desserts" idea (soda, frappuccino, chips count too). The founders
disagreed on whether to broaden beyond desserts. **Rec (🟡):** dessert-only,
user can add custom items; "sneaky desserts" as an optional later toggle, not
core. **Needs ratify.**

---

## Tier 2 — Economy design (built; needs ratification, not assumption)

### D7 · Point values 🔴  — *currently assumed, NOT ratified*
Built defaults: +10 / clean day · +1 per 1,500 steps (cap +15/day) · +5 quest
bonus · dessert costs 30 (≈3 clean days), user-adjustable 10–100. Alternative:
an onboarding quiz sets these to the person (transcript idea). **These numbers
are placeholders I chose — they need your review or a deliberate tuning pass.**

### D8 · Activity sources 🔴
Steps only (built) vs also workouts / active-energy / stand — richer earning,
more HealthKit scope. **Rec (🟡):** steps only for v1.

### D9 · Streak semantics 🔴 — *built, needs ratify*
Built as "days on plan" (clean days + fully-earned dessert days count; only an
over-budget dessert pauses it). Confirm this is the intended meaning.

---

## Tier 3 — Monetization

### D10 · Business model 🔴 — depends on D1, D3
Free · freemium · subscription · one-time. Research: dessert/habit niche
supports freemium w/ sub + lifetime; paywall-as-product-surface converts. Apple
IAP means you never hold card data. **Rec (🟡):** free v1, revisit paid at v2.

---

## Tier 4 — Design (ALL open — per your correction, nothing assumed)

### D11 Vibe 🔴 · D12 Color 🔴 · D13 Typography 🔴 · D14 Mascot treatment 🔴 · D15 Layout 🔴
Process agreed ("both in parallel"): you share Mobbin references + we ground in
Apple HIG, then decide each one explicitly. A candidate palette/type direction
exists from an earlier exploration **as options only** — not applied. See
`DESIGN-SPEC.md`.

---

## Tier 5 — Platform & feature scope

### D16 · iPhone-only vs Universal 🔴
iPhone-only cuts iPad screenshots + QA burden for v1. **Rec (🟡):** iPhone-only v1.
### D17 · Widget / Watch / Live Activities in v1 🔴
Research ranks the widget the #1 feature. Watch/Live Activities are bigger
lifts. **Rec (🟡):** Home/Lock-Screen widget in v1; Watch later.
### D18 · Notifications in v1 🔴
The evening "streak-saver" / daily check-in. Founder-requested. **Rec (🟡):**
yes, gentle + opt-in, in v1.1.

---

## Tier 3b — Community, location & discovery (NEW — founder idea 2026-07-13)

Founder: *"there could be some benefit for location sharing / community
functionality so we can have desserts with friends, or recommend amazing
places to try new desserts."* This is a substantial, exciting expansion — and
a major one. Captured here; **not** assumed into any version.

### D22 · Community / social ("desserts with friends") 🔴 — *forces D4=accounts, D5=backend*
Friends, shared dessert moments, maybe a feed. Aligns with Persona A and the
transcript's "social media just about sharing your desserts." **Implications:**
requires accounts + a real backend, content moderation, a full privacy label,
and abuse/safety handling. **Almost certainly v2**, not v1. Big value, big cost.

### D23 · Location sharing 🔴 — *highest privacy/safety sensitivity in the whole product*
"Have desserts with friends" implies sharing where you are. **This is the most
sensitive data the app could touch.** Context you need before deciding:
- Apple location model: precise vs **approximate**, **When-In-Use vs Always**
  (Always triggers extra review), a purpose string, and possible App Tracking
  Transparency. Sharing *live* location with other people raises real **personal-
  safety** obligations (granular controls, easy off, never default-on).
- Alternatives that get most of the value with far less risk: **check-in at a
  dessert spot** (a place, not your live coordinates) vs **continuous location
  sharing** (much heavier). **Rec (🟡):** if pursued, do place check-ins, not
  live location; live-location only much later with a dedicated safety design.

### D24 · Dessert-place discovery / recommendations 🔴
"Recommend amazing places to try new desserts." Context:
- **Data source** decision: a places/POI API (Apple MapKit places, Google
  Places, Foursquare — each has cost + licensing terms) vs **user-generated**
  recommendations (needs moderation) vs a curated seed list.
- Adds maps UI, a POI data model, and (if UGC) trust/moderation + spam handling.
- Could start tiny (save + share favorite spots) and grow.

### D25 · National dessert-place directory 🔴 — *large data undertaking, likely a business in itself*
Founder: *"a robust list of all the dessert places in each city in the US, so
people can discover new places."* This is a much bigger commitment than
recommendations. Context you need:
- **Sourcing:** no free, clean, comprehensive "dessert places" dataset exists.
  Options: (a) license/query a Places API (Google/Foursquare/Yelp) — **but
  their terms restrict caching, storage, and redistribution**, so you often
  can't just build your own permanent database from them; (b) **OpenStreetMap /
  Overture** (open-licensed, buildable, but patchy coverage + needs cleaning);
  (c) **build it yourself** (crowdsource/curate — accurate but slow); (d) a
  hybrid.
- **Freshness & maintenance:** places open/close constantly — a stale directory
  erodes trust fast. This is an **ongoing cost**, not a one-time load.
- **Backend, search, geo-indexing, cost** all scale with this. Realistically a
  **v2/v3 pillar or its own product**, not something to bolt onto v1.
- **Scope now includes restaurants with standout desserts**, not just dessert
  shops (founder: the best desserts are often *in* restaurants — e.g. Disney).
  This greatly expands the dataset surface.
- Lean starting point if pursued: one or two cities, curated, before "all of
  the US." Prove the discovery loop small before the data commitment.

### D26 · Geographic "start local" GTM 🔴 — *the smart way to make D25 tractable*
If discovery is pursued, start in one dessert-rich market and expand city by
city (marketplace playbook) rather than a national cold start — solves D25's
cold-start + freshness problem. **Orlando is simply the founder's home market**
and a genuinely dessert-dense, adventure-worthy one (Disney was only an example
of that density, not a strategy — see R7). **Rec (🟡):** start-local sequencing
if/when discovery is built.

**Cross-impact:** D22–D24 strongly tilt **D1** toward the social/fun persona and
would flip **D4→accounts / D5→backend**. The key question they force is **D2**:
does v1 stay solo/on-device with these as a deliberate v2, or does v1 aim
bigger? That sequencing is yours to decide — see the question below.

## Tier 6 — Go-to-market

### D19 · Name 🔴
"Toofies" final? App Store display name + subtitle. (Repo is `thetoofiesapp`.)
### D20 · Pricing 🔴 — depends on D10
### D21 · Launch plan / ASO 🔴 — depends on D3

---

## Risks, tensions & hard questions (maintained continuously)

Honest challenges to the plan so far — not blockers, but things that must be
reckoned with, not assumed away.

- **R1 · Scope creep is the live risk.** In one session the vision went from a
  solo tracker to a national social dessert-discovery platform, with no
  convergence and nothing validated. Enthusiastic capture ≠ progress; the hard
  discipline (pick a wedge, ship it, learn) is not yet in place.
- **R2 · "Tracker is a wedge into discovery" is an unproven assumption.** The
  moderation-minded tracker user and the indulgence-minded discovery user may
  be different people, or even in tension. One funnel is assumed, not shown.
- **R3 · Discovery has strong incumbents.** Google Maps, Yelp, Instagram,
  TripAdvisor, and Disney's own app already do dessert discovery. A directory
  by itself is a commodity, not a moat — only curation/community/taste could
  be defensible. This must be faced honestly.
- **R4 · Data sourcing could sink the directory.** Places-API terms typically
  forbid building/redistributing your own permanent dataset; freshness is an
  ongoing cost. Make-or-break, not a detail (see D25).
- **R5 · Nothing is validated with a real user.** All research to date is
  secondary. There is zero evidence a real person wants *this* earn-your-
  dessert loop. The highest-value next step may be user validation, not more
  building.
- **R6 · Privacy-as-a-feature vs the social/location vision directly conflict**
  (D4/D23). You cannot fully have both; a deliberate tradeoff is required.
- **R7 · Disney — CLOSED. It was only an illustrative example, never a
  strategy** (clarified 2026-07-13: *"This isn't about Disney at all — I live in
  Orlando and am referencing them as a place people go to try new desserts and
  go on adventures worth sharing."*). Own branding, no Disney IP; a Disney venue
  would at most appear as a factual location. No material legal risk. Disney is
  dropped from the analysis.

## How we'll work through this
1. Settle **Tier 0** first (D1–D3) — it disambiguates most of the rest.
2. Then Tier 1 (D4–D6) and ratify the built economy (D7–D9).
3. Design (Tier 4) proceeds on its own track as your Mobbin refs arrive.
4. Ratified decisions flow into GSD as phased plans for execution.

Nothing below Tier 0 is worth building until Tier 0 is 🟢.
