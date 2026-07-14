# Crumbl — Dessert-App Screen Patterns (reference)

**Category:** Dessert / food ordering (weekly rotating menu). **Our closest
category peer** — a beloved, well-designed app whose entire subject is dessert.
Borrow the joy and the craft; reject the drive-to-consume mechanics (see
Anti-patterns) — Crumbl is built to *maximize* dessert orders, Toofies to make
people *mindful* about them.

**Source note:** ✅ **Pixel-verified** from a large founder-provided Mobbin
capture (2026-07-14, ~25 screens) spanning: Menu/home, checkout & payment,
create-address, store locator (list/map/permission), **Loyalty (the earn-spend
economy)**, gifting, referral, email capture, catering, packaging, pickup-time.

## ⚠️ Correction to the earlier (public-source) guess

The first draft (written before pixels) said the app used a "signature-pink
background." **That was wrong, but the truth is more useful:** Crumbl runs a
**two-register color system** —

- **Commerce chrome = stark black-and-white.** Pure-white screens, near-black
  text, **solid-black pill buttons**, white rounded input fields. Zero brand
  color in the functional UI. Premium, confident, calm.
- **Emotional moments = pink.** Pink appears *only* in illustrated/playful
  contexts: loyalty "crumbs", gift-card art, celebration illustrations, the
  Gifts tab icon when active. The pink is a **reward/delight accent**, never
  chrome.

**Lesson for Toofies:** a restrained near-monochrome shell + a single warm
accent *reserved for delight* (celebration, rewards) is a proven, premium
pattern in our exact category. (Direction only — un-ratified.)

## Observed design language (from real pixels)

- **Solid-black pill CTA, everywhere.** MAKE PURCHASE / SAVE & USE ADDRESS /
  REVIEW ORDER / CONTINUE / NEXT / SIGN UP FOR DEALS — one heavy black pill =
  the primary action on every screen. Unmistakable.
- **Huge bold headings** (tight, near-black), often with a small **gray
  uppercase eyebrow** above ("HALF PINT", "FROM:", "AMOUNT").
- **White rounded input fields** with generous padding on a light-gray form
  background; native iOS keyboards.
- **Segmented pill toggle** (List / Map) — black fill = selected, outline =
  unselected. Clean reusable control.
- **Custom line-art illustrations with pink fills** + short **lowercase playful
  copy** ("you're a treasure", "we appreciate you") — the warm, human layer.
- **Reward chips:** small **black pill with `+5`** denoting points earned per
  action — crisp, legible, motivating.
- **Product-as-hero photography** bleeding off white (Menu screen), asymmetric
  placement, lots of negative space.
- **5-tab bottom bar:** Menu · Order · Loyalty · Gifts · More, custom line-art
  icons; active icon picks up pink (Gifts/Loyalty).

## Flow-by-flow notes

- **Loyalty — the earn/spend economy (most relevant to Toofies).** "Earn Free
  Crumbs" is a vertical list of action rows (Refer a friend, Rate the app, Join
  birthday club, Follow us…) each with a **`+5` black reward chip**. A "How does
  Crumbl Loyalty work?" explainer + FAQ states the rule plainly: **spend $1 → 1
  Crumb; 100 Crumbs → $10 Crumbl Cash, then crumbs reset to 0.** A black
  **balance card** ("Crumbl Cash $0.00") flips to a **scannable QR** ("SCAN TO
  USE IN STORE"). This is a full earn-and-spend loop with a threshold payout —
  the exact *shape* of the Toofies points economy.
- **⭐ Loyalty HOME / "Crumbl Card" (the economy's home surface).** The Loyalty
  tab opens on: the black card ("TAP TO USE", "US$0.00 CRUMBL CASH") with a
  **progress bar directly under it — "CRUMBS 0 / 100 · 100 more to earn
  US$10"** (pink cookie icon at the left) — then the pink "Earn Free Crumbs"
  banner, then an **"Activity" feed** ("No crumbl card activity yet" empty
  state). This *progress-toward-the-next-reward bar* is structurally exactly a
  Toofies **"points toward your next dessert"** home. Study it closely.
- **Store locator.** Search field + List/Map pill toggle; map uses Apple Maps
  with a **red pin**; list rows show store name, address, **distance in miles**
  (bold). Clean loading state (animated logomark). Relevant to our future
  dessert-place discovery.
- **Location permission.** Native iOS sheet with a **map preview** behind
  "Allow 'Crumbl' to use your location? To find the closest store!" — a
  purpose-first permission ask. Useful reference for our privacy/discovery work.
- **Gifting.** "Select a gift card design" (categorized: Birthday / Any Time /
  Family / Graduation / Appreciation) with **pink illustrated cards**; amount
  stepper (− US$5 +); From/To, add-message, send-date; REVIEW ORDER.
- **Referral.** Confetti illustration, a **short share link** (cmbl.co/…) with
  copy button, "Pending Referrals (0)" empty state.
- **Email capture.** "Sign up for deals" modal, `+5 Free Crumbs` chip top-right,
  single email field, black CTA — reward-gated list-building.
- **Checkout / catering / packaging / pickup.** Contact details, address form,
  packaging option cards (FREE / +$7 / +$12.50), a **± stepper time picker**
  (2:00 / PM), order review with subtotal. The consumption machinery.
- **⭐ Post-experience reflection loop (NEW — highly relevant to Toofies).**
  After an order, a warm multi-step reflection: (1) **emoji rating** — five
  faces from 😠→😍, "How would you rate your experience today?"; (2) **"Take a
  photo of your cookie(s)?"** with a Skip; (3) optional free-text "Any other
  feedback?"; (4) a **reward-celebration** — "Thank you for your feedback! **+1
  Free Crumb Earned**" with confetti illustration. The receipt itself also
  celebrates: "**YOU EARNED 24 LOYALTY CRUMBS!**" with the pink cookie icon.
  This is a template for making *reflection/logging* feel warm and rewarded.
- **Auth = phone OTP, with Skip.** Sign-in is name + phone → 4-digit code
  (round OTP fields) → **you can Skip entirely**. Crumbl works without an
  account — real-world validation of a guest-first / on-device stance.
- **Order-type selection.** Big selectable **cards on black** (Delivery / Store
  Pickup / Catering / Shipping), each icon + title + one playful line. Clean
  selectable-card pattern.
- **Selection & disabled states.** Catering date list shows **strikethrough +
  "(Booked)"/"(Closed)"** for unavailable days and a **black-fill card with a
  white checkmark** for the selected day — legible state design.
- **Delivery tracking.** Live map (home + store pins, dashed route), "Arriving
  in X min", a 3-step **progress stepper** (prep → truck → hand-off) with
  status label. Reference for any future live-status UI.

## Principles worth stealing

- **Two-register color:** quiet monochrome shell + a warm accent reserved for
  reward/celebration. (Strong candidate direction for Toofies.)
- **One black pill = the one primary action per screen.**
- **Eyebrow + huge title** header (maps to our `EyebrowLabel`).
- **`+X` reward chips** make earning legible and motivating.
- **Threshold payout** (100 crumbs → $10, then reset) — a satisfying
  earn-toward-a-reward loop.
- **Purpose-first permission asks** ("…to find the closest store").
- **Illustration + lowercase playful copy** for warmth.

## Anti-patterns — what Toofies must NOT copy

- **The moral inversion of the economy.** Crumbl rewards **spending** ("spend
  $1 → 1 crumb"); Toofies rewards **not** consuming (clean days, movement).
  Borrow the *shape* (earn → threshold → reward, with a visible balance and
  reward chips); **invert the trigger** — never pay users to eat more.
- **The entire order/checkout/catering funnel** — no payment, no cart in
  Toofies. Don't import it.
- **Scarcity/FOMO, buy-more nudges, reward-gated data grabs** ("+5 crumbs to
  sign up for deals"). Toofies' rewards attach to health behavior, not
  marketing consent.
- **Craving-trigger imagery as a prompt** — hero dessert art celebrates a
  *logged* treat; never bait the next purchase.

## → Toofies mapping

*(Design is un-ratified — a proposed mapping to react to, not decided.)*

| Crumbl pattern (observed) | Toofies equivalent |
|---|---|
| Two-register color (mono shell + pink for delight) | Quiet UI + one warm accent reserved for celebration/rewards (candidate) |
| Loyalty earn/spend + threshold payout | **Points economy** — but earned from clean days/steps, spent on desserts |
| `+5` black reward chips on a "ways to earn" list | A "ways to earn points" surface with clear reward chips |
| Scannable balance card (Crumbl Cash) | A **balance/streak card** as the home centerpiece (no QR/no cash) |
| Eyebrow + huge bold title | Reuse `EyebrowLabel` + oversized title |
| Solid-black pill primary CTA | One clear primary action per screen |
| List/Map pill toggle | Reusable segmented toggle (our `LaneTabs` analog) |
| Store locator + distance list + map pins | Future dessert-place **discovery** UI |
| Purpose-first location permission | Our privacy-respecting permission asks |
| Pink illustrated celebration cards + lowercase copy | **Sweet Toofies** celebration moments, warm + playful |
| Entire checkout/catering funnel | **Explicitly NOT copied** — no payment, no cart |

**Behavioral-safeguard check (PRODUCT.md):** Crumbl proves an earn/spend dessert
economy *works and delights* — but it pays people to **consume**. Toofies keeps
the satisfying loop and **inverts the trigger** to reward mindfulness and
movement. Borrow the craft (two-register color, pill CTAs, reward chips,
celebration illustration); leave the buy-more engine behind.
