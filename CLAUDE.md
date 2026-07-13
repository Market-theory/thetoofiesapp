# Toofies — Operating Constitution (Claude Code)

**IMPORTANT: These rules OVERRIDE default behavior. Follow them exactly.**
They exist to guarantee that no decision is ever made by assumption or skipped
without its full context. This file loads at the start of every session.

## 1. The Decision Gate (the core rule)

- **Never apply a material decision that is not 🟢 RATIFIED in
  `.planning/DECISION-REGISTER.md`.** Material = anything visual (color, type,
  layout, icon, mascot), architectural (accounts, backend, data model),
  economic (point values, pricing), scope, naming, or monetization.
- When work requires such a decision, **STOP and surface it**: state the
  decision, its context, the options with tradeoffs, and a recommendation.
  **The founder decides.** Do not proceed on the un-ratified choice.
- If you discover a *new* decision mid-task, add it to the Decision Register as
  🔴 OPEN and surface it — do **not** decide it yourself to keep moving.

## 2. No Assumptions

- If an input you need is unknown, **ask** — never fill it silently.
- Prototype/placeholder defaults (e.g. current colors, the 10/30 point values)
  are **not decisions**. Always label them as placeholders, never present or
  treat them as settled.
- Do not present your recommendation as though it were chosen. 🟡 PROPOSED ≠
  🟢 RATIFIED.

## 3. Source of Truth (in order)

1. `.planning/DECISION-REGISTER.md` — every material decision + status.
2. `.planning/PRODUCT.md` — vision & locked framing rules.
3. `.planning/DESIGN-SPEC.md` — design decisions (currently: none made).
4. `.planning/research/*` — verified market/features/gamification research.

On any conflict, the Decision Register wins. If a decision is missing or
ambiguous, **ask** — do not infer.

## 4. Process: spec-driven, WHAT before HOW

- Use the **GSD** workflow for any new feature: spec (WHAT + ambiguity check) →
  discuss (gather context) → plan → execute → verify. No building ahead of a
  ratified spec.
- Design work is gated: invoke design skills (`ui-ux-pro-max`, `design-review`)
  only to produce **options for review**, never to apply a direction. Ground
  iOS specifics in Apple's Human Interface Guidelines.

## 5. Locked framing rules (from PRODUCT.md — do not violate)

- Playful, never punitive. No calories, weight, or diet language. Honest
  logging is never blocked. Forgiving by design (no hard streak resets, no debt).
- **Privacy:** the app collects **no** user data unless an accounts/backend
  architecture is 🟢 RATIFIED (D4). Until then, on-device only.

## 6. Research & claims

- Cite sources; prefer adversarially-verified claims; label confidence. Never
  present an unverified claim as fact.

## 7. Git

- Develop on the working branch; commit atomically with clear messages; push
  after committing. End commit messages with the session's Co-Authored-By /
  Claude-Session trailers. Never expose the model identifier in artifacts.
