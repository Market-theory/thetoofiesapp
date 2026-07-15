# Toofies — Agent Build Spec

**Audience:** an autonomous coding agent (Claude Code) building Toofies v1.
**Companion docs:** `PRD.md` (what/why), `DECISION-REGISTER.md` (authoritative
decisions), `CLAUDE.md` (operating constitution). **On any conflict, the
Decision Register wins; if a decision is missing or ambiguous, STOP and ask —
never infer.**

> **How to read this spec.** It is scoped to the **🟢 ratified v1 core** only.
> Every open decision is marked **🚧 STOP-GATE** — at a stop-gate the agent must
> surface the decision (context + options + recommendation) and **wait for the
> founder**, not choose. Building past a stop-gate violates the constitution's
> Decision Gate (§1).

---

## 0. Prime directives (read first, obey always)

1. **Decision Gate.** Do not apply any material decision (visual, architectural,
   economic, scope, naming, monetization) that is not 🟢 RATIFIED in
   `DECISION-REGISTER.md`. Placeholders (e.g. point values, current colors) are
   **not** decisions — never treat them as settled.
2. **No design.** Colors, typography, mascot form, and layout are **all 🔴 OPEN**
   (D11–D15). Build **un-styled functional scaffolding** only — structural
   spacing/borders, system defaults. Do **not** introduce a palette, font,
   or brand treatment. Design arrives later through the design gate.
3. **Safeguards are law** (PRD §6). Any earn/spend food surface must obey them.
   When compliant framing isn't yet defined, that's a **🚧 STOP-GATE**, not a
   place to improvise copy.
4. **On-device only** (D4). No network calls carrying user data. No accounts, no
   backend, no analytics SDK. Apple Health is read-only + opt-in.
5. **Ship gate.** The **economy cannot ship to real users** until the
   **ED-specialist review** clears. The recency core may be built/previewed
   freely.
6. **Verify, then commit.** Every change must pass the verification gates (§8)
   before commit. Commit atomically; push after each commit; use the session
   commit trailers; never expose the model identifier in artifacts.

---

## 1. Current state of the codebase (ground truth)

Repo: `market-theory/thetoofiesapp`, app at `toofies/` (Expo SDK **56**,
expo-router, TypeScript). Verified working: `tsc` clean, `expo export`
bundles, economy parity test passes, web preview live.

**Already built & verified (reuse — do not rewrite):**

| File | What it is | Status |
|---|---|---|
| `toofies/src/lib/economy.ts` | Pure economy engine — balance ledger (floor-0 forgiveness), availability, `onPlanStreak`, recency, adaptive `questGoal`, `activityPoints`, `lastSevenDays`. `now` injected everywhere (deterministic). | ✅ ported + parity-tested |
| `toofies/src/lib/treats.ts` | `TreatKind` catalog (8 emoji), `TreatEntry`, `makeEntry`. | ✅ |
| `toofies/src/lib/store.tsx` | `StoreProvider` + `useStore` + `useToofies` view-model. AsyncStorage persistence (`STORAGE_KEY='toofies.v2'`), hydrate-then-persist. Actions: `logDessert`, `removeEntry`, `setDessertCost`, `reset`. | ✅ |
| `toofies/src/app/index.tsx` | Home scaffold (un-styled by intent). | ⚠️ **RESHAPE** (leads with economy — see §3) |
| `toofies/scripts/economy.test.mjs` | Parity test (TZ-fixed, compiles TS, 5 scenarios). | ✅ keep green |
| `toofies/preview/index.html` | Vanilla-JS web preview of the engine (diff-tested faithful). | ✅ reference only |

**Not built yet (this spec's work):** recency-only mode + toggle, settings,
ED-resources surface, milestone celebration surface, dessert-log detail/history,
Apple Health module wiring, widget (if ratified), notifications (v1.1).

**Leftover starter cruft to remove during reshape:** `src/app/explore.tsx`,
`src/components/{animated-icon,app-tabs,themed-text,themed-view,web-badge,
hint-row,external-link,ui/collapsible}` and demo assets, unless a piece is
deliberately reused. Removing cruft is allowed (not a material decision); do it
in a dedicated commit.

---

## 2. Architecture

- **Framework:** Expo SDK 56 / React Native, `expo-router` file-based routes in
  `src/app/`. Keep SDK pinned to 56 (Expo Go App-Store compatibility).
- **State:** single `StoreProvider` (React context) over the `EconomyState`
  shape; all derived values come from **pure** `economy.ts` functions, never
  recomputed ad hoc in components. Extend `useToofies` for new derived views.
- **Persistence:** AsyncStorage, one JSON blob under `toofies.v2`. Any schema
  change is **additive + migration-safe** (hydrate merges over `initialState`);
  bump the key only with a written migration.
- **Time:** never call `Date.now()` deep in logic — thread `now` in (matches the
  engine's deterministic contract; keeps everything testable).
- **Data model (do not change without a stop-gate):**
  - `EconomyState { dessertCost, entries: TreatEntry[], healthConnected,
    stepsByDay: Record<dayKey, number>, installDate }`
  - `TreatEntry { id, emoji, name, date: ISO, pointsSpent }`
  - **New for v1:** add `economyEnabled: boolean` (default **false** — safe core
    first) and `mode`-independent recency. This is the one additive field the
    recency/economy split needs; it is a **structural** flag, not an economic
    value, so it's in-scope. Persist it; default off.

---

## 3. The reshape (do this before adding features)

The ratified direction is **recency-first, economy opt-in** (PRD §4). The current
home leads with the economy and uses penalizing framing. Reshape in order:

1. **Introduce `economyEnabled` (default false).** Recency core renders with it
   off; economy surfaces render only when on.
2. **Make recency the hero** of the home screen (structure only — no visual
   design): last-dessert date, days-since, "log a dessert," recent history.
3. **Move economy behind the toggle.** Points/streak/quest/"am I safe" render
   **only** when `economyEnabled`. Keep it clearly labeled an **experiment**.
4. **Framing compliance — 🚧 STOP-GATE (safeguards #1/#2/#3).** The existing copy
   ("Am I safe to have a dessert?", "cost/afford/spend," "banked N desserts,"
   score dropping on spend) **violates the locked safeguards.** Do **not** invent
   replacement copy. Surface a copy/framing decision (options + rec) and wait.
   Until ratified, the economy surface stays behind the toggle in its current
   **explicitly-labeled experimental scaffold** state, not shipped to users.
5. **Delete starter cruft** (separate commit).

> The reshape changes **structure and gating**, which is ratified scope. It does
> **not** decide framing/design — those remain gated.

---

## 4. Screens & surfaces (functional requirements — NO visual design)

For each: build behavior + structure with system defaults and neutral scaffolding
only. All labels marked 🚧 are stop-gates (safeguard-bound copy).

### 4.1 Home — recency core (P0, 🟢)
- Show: last-dessert date; days-since ("No desserts logged yet." / "You had a
  dessert today." / "It's been N days…"); clean-so-far-today indicator.
- Primary action: **Log a dessert** (opens 4.2).
- Recent history: last 7 days (`lastSevenDays`) as a simple row/list.
- Renders fully with `economyEnabled === false`.

### 4.2 Log a dessert (P0, 🟢 mechanic)
- Pick from the dessert set → `logDessert(kind, now)`; entry persists.
- **Dessert set is 🚧 STOP-GATE (D6):** fixed emoji set vs custom vs "sneaky
  desserts." Until ratified, use the existing 8-emoji `TREATS` catalog as a
  **labeled placeholder** (it already ships in code; using existing built data is
  not a new decision — but surface D6 so the founder ratifies the real set).
- Never block or shame a log (safeguard). Allow undo/remove (`removeEntry`).

### 4.3 Economy surface (P0 as opt-in, framing 🚧)
- Visible only when `economyEnabled`. Shows earn/spend balance, on-plan streak,
  quest, milestone progress — **using `economy.ts` outputs unchanged.**
- **All user-facing economy copy is a 🚧 STOP-GATE** (safeguards #1–#3). Build the
  data plumbing; leave copy in the current experimental-scaffold state behind the
  toggle. Do not ship.

### 4.4 Milestones / celebration (P1, logic 🟢 / visual 🔴)
- Detect `streakMilestoneToday`; celebration **visual/mascot is design-gated**
  (D14). Build a structural hook only; no mascot art, no confetti design.

### 4.5 Settings (P0 plumbing)
- Toggle **economy experiment on/off** (writes `economyEnabled`).
- Connect Apple Health (opt-in) — see §5.
- Dessert cost control — **🚧 STOP-GATE (D7)**; expose only if/when values
  ratified; otherwise hide or label placeholder.
- **Reset / export** on-device data.
- **ED-resources link** (4.6).

### 4.6 ED-resources signposting (P0, 🟢 safeguard #5)
- A always-available, non-alarming surface linking to eating-disorder support
  resources. Content/resource list is factual; **surface it for founder sign-off**
  (which resources/region) — treat the specific resource list as a light
  stop-gate (get confirmation), but the *presence* of the surface is required.

### 4.7 Apple Health (P1)
- See §5. Opt-in, read-only steps → `stepsByDay` → activity points via existing
  engine. Framing must **not** present steps as paying for dessert (safeguard #3).

### 4.8 Widget / Notifications
- **Widget (🚧 D17)** and **notifications (🚧 D18)** — do not build until
  ratified. Notifications are v1.1 regardless.

---

## 5. Apple Health integration (P1)

- **🚧 STOP-GATE on module choice:** pick the Expo health approach (e.g. an Expo
  config-plugin health module) and surface it — it affects native build config
  and App Store review. Recommend, don't decide unilaterally.
- Read-only, steps only for v1 (D8 rec — confirm). Opt-in with a clear purpose
  string. Writes into `state.stepsByDay[dayKey]`; the engine already credits it.
- Must degrade gracefully when unavailable/denied (economy still works on
  clean-day base points; recency core unaffected).
- On-device only — no step data leaves the device.

---

## 6. What the agent MUST NOT do (hard stops)

- ❌ Choose any color, font, mascot rendering, or layout aesthetic (D11–D15).
- ❌ Write user-facing economy copy that implies cost/afford/spend/penance, or
  celebrates abstinence (safeguards #1–#3).
- ❌ Ratify or change point values (D7), the dessert set (D6), or streak
  semantics (D9).
- ❌ Add accounts, networking, analytics, or any off-device data flow (D4).
- ❌ Build social/location/discovery (D22–D26) — out of v1 entirely.
- ❌ Ship the economy to real users before the ED-review gate clears.
- ❌ Upgrade/downgrade the Expo SDK off 56 without surfacing it (breaks Expo Go).
- ❌ Silently continue the current economy-first framing — it's a tracked reshape.

At every ❌ that the work appears to require: **STOP, add/mark the decision in
`DECISION-REGISTER.md` as 🔴 OPEN if not present, surface options + a
recommendation, and wait.**

---

## 7. Build sequence (suggested waves — each ends green + committed)

1. **Wave 0 — Reshape & clean:** add `economyEnabled` (default off); recency-first
   home; gate economy behind toggle; delete starter cruft. Surface the framing
   stop-gate (§3.4). *No new features.*
2. **Wave 1 — Recency core complete:** log flow (4.2), history, settings shell
   (4.5), ED-resources surface (4.6). Fully usable with economy off.
3. **Wave 2 — Economy plumbing (behind toggle, unshipped):** wire economy surface
   (4.3) + milestone hook (4.4) to the engine; keep copy in labeled experimental
   state pending the framing stop-gate.
4. **Wave 3 — Apple Health (P1):** module stop-gate → opt-in steps → activity
   points.
5. **Design waves (SEPARATE, gated):** only after the founder ratifies D11–D15 via
   the design gate. Not part of this spec's scope.
6. **Pre-ship gates:** ED review (economy), code-review + security-review, owed
   Codex cross-model pass (local), D3/D16/D19/D21 ratified.

Each wave: implement → verify (§8) → atomic commit → push.

---

## 8. Verification gates (must pass before every commit)

- **Typecheck:** `npx tsc --noEmit` clean.
- **Economy parity:** `node scripts/economy.test.mjs` → ALL PASS (TZ-fixed).
  If engine logic changes, extend this test first.
- **Bundle:** `npx expo export --platform ios` succeeds (proves it compiles).
- **`npx expo-doctor`** — 19/21 expected in the sandbox (2 network-only checks
  fail behind the proxy; that's environmental, not a defect).
- **Behavior check** (`/verify` skill spirit): drive the actual changed flow
  (log a dessert, toggle the economy, hydrate after reload) — not just types.
- **Reviews:** run Claude `/code-review` + `/security-review`; **flag the owed
  Codex cross-model pass** for the local environment (constitution §4).
- **No design/decision leakage:** confirm the diff introduces no palette/font/
  brand and no un-ratified economic values or copy.

---

## 9. Definition of done (v1 core)

- Recency-only mode is a complete, usable, on-device experience (safeguard #4).
- Economy exists **only** behind an explicit opt-in toggle, default off, with
  engine outputs intact and framing **still gated** (unshipped) until ratified +
  ED-reviewed.
- ED-resources surface present. On-device only; no data leaves the device.
- All verification gates green; starter cruft removed; SDK 56 intact.
- Every open decision (D3, D6, D7, D8, D9, D11–D15, D16, D17, D18, D19, D21) is
  either 🟢 ratified or clearly surfaced and **not** silently resolved.
- **Not done until:** the ED-review + code-review gates are satisfied for
  anything shipped to real users.

---

## 10. Traceability

| Build item | Ratified basis | Open gate |
|---|---|---|
| On-device store, no accounts | D4, constitution §5 | — |
| Recency-only safe core | D2, safeguard #4 | — |
| Economy behind opt-in toggle | D7–D9 (experiment), safeguard #6 | framing copy, D7 values |
| No design applied | DESIGN-SPEC (nothing decided) | D11–D15 |
| Expo/RN, SDK 56 | D27 | SDK bumps |
| ED-resources + ED-review ship gate | safeguards #5, ratified gate | resource list |
| Dessert set = existing 8 emoji (placeholder) | code as-is | D6 |
| Apple Health steps, read-only opt-in | D8 (rec) | module choice, D8 confirm |
| Widget / notifications | — | D17 / D18 |
| Platform iPhone-only | — | D16 |
