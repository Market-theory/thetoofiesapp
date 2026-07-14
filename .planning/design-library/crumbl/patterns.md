# Crumbl — Dessert-App Screen Patterns (reference)

**Category:** Dessert / food ordering (weekly rotating menu). **This is our
closest category peer** — a beloved, well-designed app whose entire subject is
dessert. That makes it the single most on-target reference *and* the one we
must borrow from most carefully: Crumbl is engineered to **maximize** dessert
consumption; Toofies exists to help people be **mindful** about it. Borrow the
joy and the craft; reject the drive-to-consume mechanics (see Anti-patterns).

**Source note:** knowledge- and public-source-based, **not** Mobbin pixels —
Mobbin is login-gated from the cloud env (403, verified 2026-07-14). Exact
Mobbin screen URL recorded in `screens/SOURCE.md` for a local pixel pull.
**Refine against real screenshots when available.**

## The flows worth studying

1. **Home / "This Week's Menu."** The hero is **huge, top-down dessert
   photography** — the cookie is the star, shot on the clean signature-pink
   background. A rotating weekly lineup (usually 6 flavors) presented as a
   vertical stack or carousel of big photo cards.
2. **Flavor detail.** One giant hero photo, flavor name in a confident display
   weight, a short indulgent description, nutrition, and rating. The dessert is
   celebrated, never clinical.
3. **Rating / "your reviews."** After you've tried a flavor you rate it (stars);
   your history of rated flavors builds a personal record. A logging-and-
   rating loop that's *emotionally rewarding*, not administrative.
4. **Weekly cadence / novelty.** The menu changes every week (Sunday reset),
   with a countdown and "new week" reveal — a recurring ritual moment.
5. **Locations / order.** Nearby stores, pickup/delivery, simple cart.
6. **Onboarding.** Light — location permission, then straight into the menu.

## The principles worth stealing

- **Food is the hero.** Big, warm, appetizing dessert imagery as the emotional
  centerpiece of the screen. For Toofies this validates making the dessert
  (photo or expressive emoji) the visual anchor of a logged treat, not a
  line-item.
- **Indulgence framed as joy, not shame.** Copy and art treat dessert as a
  delight. This is exactly the tone Toofies wants: *guilt-free*, celebratory —
  we are pro-dessert, just mindful about frequency.
- **A recurring weekly ritual.** The Sunday menu reset is a habit anchor.
  → informs a Toofies **weekly recap / reset moment**.
- **Rating turns consumption into a personal record.** The "flavors I've tried +
  rated" pattern is a warm, low-friction logging loop.
- **Confident, clean layout.** Generous whitespace, one clear focus per screen,
  a single signature accent color doing a lot of work.

## Anti-patterns — what Toofies must NOT copy

Crumbl's design goals are the **opposite** of ours, so several of its best
tricks are hazards for us:

- **Scarcity / FOMO ("only this week!").** Engineered to drive urgent
  purchases. Toofies must never manufacture urgency to consume dessert.
- **Consumption-maximizing nudges** (push notifications to order, "new drop"
  alerts). Toofies' nudges point toward *mindfulness and movement*, never
  "go get a dessert now."
- **Craving-trigger imagery at the wrong moment.** Big dessert photography is
  wonderful for celebrating a logged treat; it's a trap if used to *prompt*
  eating. Context matters — celebrate the past treat, don't bait the next one.

## → Toofies mapping

*(Design is un-ratified — a proposed mapping to react to, not decided.)*

| Crumbl pattern | Toofies equivalent |
|---|---|
| Top-down hero dessert photography | **The logged treat as hero** — expressive emoji/photo anchors the moment |
| Indulgence-as-joy tone | Core Toofies voice: guilt-free, pro-dessert, mindful |
| Weekly menu reset ritual | **Weekly recap** — "your week in desserts," a gentle habit anchor |
| Rate-what-you-tried loop | Logging feels like a warm personal record, not a ledger entry |
| One signature accent, clean layout | Supports a restrained Toofies palette (un-decided) doing confident work |
| Scarcity/FOMO, order nudges | **Explicitly rejected** — never drive urgent consumption (PRODUCT.md safeguards) |

**Behavioral-safeguard check (PRODUCT.md):** borrow Crumbl's *warmth toward
dessert*, never its *pressure to buy more*. Celebrate the treat someone chose;
never bait the next one.
