# Strava — Activity/Health Screen Patterns (reference)

**Source note:** gathered from **public** descriptions, not Mobbin pixels
(Mobbin was unreachable from the cloud env — see SESSION-STATE.md). Sources:
Strava's own [Activity Page guide](https://stories.strava.com/articles/strava-guide-your-activity-page-101)
and [Run Activity Pages support](https://support.strava.com/en-us/articles/15401883-run-activity-pages),
[Page Flows – Strava](https://pageflows.com/screens/mobile/product/strava/),
[Strava Live Activities (iOS)](https://support.strava.com/en-us/articles/15401559-strava-live-activities-on-ios),
and community feedback on the 2025 redesign
([1](https://communityhub.strava.com/strava-features-chat-5/new-activity-layout-is-atrocious-9870)).
**Refine against real screenshots when available.**

## The activity-summary screen — anatomy (top → bottom)

1. **Hero: map + 3 headline metrics.** The activity opens with the route map
   and the three numbers that matter most — **time, distance, pace** — large
   and first. (Live Activities show these same three on the Lock Screen.)
2. **Secondary stat grid.** Elevation, cadence, calories, heart rate, etc. as
   smaller, recessive tiles below the hero. What shows depends on space — the
   headline three get priority; extras yield.
3. **Splits list.** Per-mile/km rows with basic info each — progressive detail
   for those who want it.
4. **Pace-over-elevation chart.** Real-time pace overlaid on the elevation
   profile; **darker bars = faster, lighter = easier.** Grade-Adjusted Pace
   normalizes for hills. This is how effort-over-time is visualized.
5. **Photos, then social.** Media, then kudos + comments at the bottom.

## The principles worth stealing

- **Hierarchy is everything:** 2–3 numbers dominate; everything else recedes.
- **Progressive disclosure:** headline metrics up top, charts/splits below.
- **Effort visualized over time**, not just totaled — the pace/elevation chart
  makes the activity feel like a story, not a number.
- **Completion feels like an event** — finishing an activity is a moment, not
  a silent save.
- **Lock Screen = exactly 3 metrics.** Ruthless prioritization when space is
  tiny.

## Anti-pattern (their own misstep)

The 2025 redesign was widely criticized for **cramming map + stats + photos
onto one crowded page** ([community thread](https://communityhub.strava.com/strava-features-chat-5/new-activity-layout-is-atrocious-9870)).
Lesson for Toofies: keep the activity view **focused** — a few meaningful
numbers, not everything at once.

## How this maps to Toofies' activity/health screen

*(Design is un-ratified — this is a proposed mapping to react to, not decided.)*

| Strava pattern | Toofies equivalent |
|---|---|
| Hero: time / distance / pace | **Hero: steps today + points banked** (2 big numbers, first) |
| Secondary stat grid | Quest progress + days-on-plan streak as recessive tiles |
| Pace-over-elevation chart | **Steps-over-the-week trend** — movement accumulating toward the next treat |
| Completion is an event | **"Quest complete / activity banked"** celebration moment |
| Lock Screen = 3 metrics | Widget / Live Activity: steps · points today · balance |
| "Don't overcrowd" lesson | Keep Toofies' activity card to a few meaningful numbers |

Behavioral-safeguard check (per PRODUCT.md): frame activity as *movement that
adds to your day*, never as "earning the right to eat" — steps contribute
points, but the copy stays celebratory of movement, not compensatory.

---

## ✅ Pixel-verified — observed design language (founder Mobbin pull, 2026-07-14)

First real Strava screens received. Batch 1 = the **create-a-club onboarding
flow** (not the activity/stats screens — those are still the priority pull).
Even so, the UI grammar is highly instructive:

- **Signature orange accent (~#FC5200)** on the primary pill CTA and on
  selection controls — used sparingly against an otherwise black/white/gray UI.
  (Same *restrained-shell + one warm accent* principle we saw in Crumbl, just a
  different hue — a recurring, reassuring convergence.)
- **Multi-step progress bar** — a 5-segment bar pinned to the top of a modal
  sheet; completed steps fill black. Clear "where am I in this flow" signal.
- **Selectable list rows, two modes:**
  - *Multi-select* (tags): unselected = light-gray pill row with an empty
    square; **selected = black-fill row + orange checkbox**. Bold, legible.
  - *Single-select* (sport): **icon + title + description** rows with a radio
    on the right; selected radio fills orange.
- **Disabled CTA state** = the orange pill goes faded/peach until the form is
  valid — a gentle, obvious gate.
- **⭐ Reassurance microcopy:** *"You can always change this later"* sits above
  the CTA on every step. A low-pressure, forgiving onboarding tone that fits
  Toofies' non-punitive framing perfectly.
- **Big bold title + gray sub-instruction** header (e.g. "Which best describes
  your club?" + "Pick up to 3 tags…") — same eyebrow/title/subtitle grammar.

### → Toofies mapping (onboarding & selection)

| Strava pattern (observed) | Toofies equivalent |
|---|---|
| 5-segment top progress bar | Multi-step **onboarding** progress indicator |
| Black-fill + orange-check selected row | Selectable options (e.g. favorite desserts, goals) |
| Icon + title + description radio rows | Clean single-select lists (mode, plan) |
| Faded pill until valid | Gentle "finish this step" gating |
| "You can always change this later" | **Forgiving onboarding voice** — reduces commitment anxiety (on-brand) |
| Restrained shell + one warm accent (orange) | Reinforces the two-register color direction (accent hue TBD) |

**Still most wanted from Strava:** the **activity detail / stats** screen, a
**weekly/progress trend**, and the **record/start** flow — the health-and-effort
patterns Crumbl can't teach us. These onboarding screens are a bonus, not the
core reference.

---

## ✅ Pixel-verified — activity, recording & stats (founder pull, batch 2)

The core reference has arrived — the health/effort screens. This **replaces the
reconstructed activity anatomy above with real pixels** and confirms most of it.

### The screens

- **Activity detail (the canonical summary).** Top: route map with **gold "PR"
  badges** pinned on it ("Fastest 1K Lifetime"). Then athlete row (avatar in an
  **orange shield frame** + name + "Afternoon Run" + sport icon + time/place).
  Then a **PR celebration card** — "⭐ Your fastest 1K in 2026! Tap to view your
  1K analysis." Then a **2-column stat grid** (label-over-value, big bold
  values): Distance / Avg Pace / Moving Time / Elevation Gain / Calories / Max
  Elevation. Then an **"Athlete Intelligence"** (AI insight) section.
- **Live recording — glanceable.** Full-screen, near-monochrome: a huge running
  **split pace ("3:00")**, a huge **distance ("0.03")**, a small elapsed timer
  up top, a **Splits** mini-bar, and a full-width **orange Pause pill**.
  Ruthless big-number hierarchy — two numbers dominate.
- **Live recording — map mode.** Map with the live route (blue done / orange
  ahead), a **blue "Split 1 complete!" toast** with a 3-metric block (Time /
  Split avg pace / Distance), map controls (compass, layers, 3D), orange Pause.
- **Laps chart (dataviz).** A **bar chart of per-lap pace** (blue bars) layered
  over a **ghosted gray elevation profile**, x-axis = lap number; below it a
  **LAPS table** (lap · distance · time · pace). Excellent effort-over-segments
  visualization.
- **Maps / Routes discovery.** Search + **filter chips** (Length / Elevation /
  Surface / Difficulty), a route heatmap, "Create Route", a **route card**
  (thumbnail + name + Easy tag + distance/time + "Made for you"), "147 Routes",
  and the **5-tab bar** (Home · Maps · Record · Groups · You, Record = a bold
  center target icon).

### Design language confirmed

- **Orange = action/energy** (Pause pill, active tab, live route). **Gold =
  achievement** (PR badges/cards) — a deliberate *second* accent just for
  milestones. Everything else black/white/gray. (Two-register, again — plus a
  dedicated achievement color. Worth noting for Toofies.)
- **Big-number hierarchy:** 1–2 metrics dominate; the rest recede to a grid.
- **Completion = a micro-celebration** (the "Split complete!" toast; the PR card).

### → Toofies mapping (the core one)

| Strava pattern (observed) | Toofies equivalent |
|---|---|
| 2-col stat grid (label over big value) | **Toofies stat tiles** — steps, points banked, days on plan, recency |
| PR celebration card ("fastest 1K in 2026!") | **Milestone/streak celebration card** ("Sweet Toofies" moment) |
| Gold achievement accent (distinct from orange) | A dedicated **celebration accent** for milestones (hue TBD) |
| Glanceable huge-number view | Toofies **"today" glance** / widget / Live Activity |
| "Split complete!" 3-metric toast | **"Clean day banked / quest complete"** micro-celebration |
| Laps bar-chart over ghost elevation | **Steps-over-the-week** bar chart (dataviz reference) |
| Maps/Routes filter chips + route cards | Future **dessert-place discovery** UI |
| Orange-shield avatar frame | (Echoes our canonical completion-ring/SPEAKER-badge idea) |

**Behavioral-safeguard check:** adopt Strava's *celebration of effort and
progress* and its clean stat hierarchy — but Toofies celebrates **movement that
adds to the day**, never "pace/performance you must beat." Keep the achievement
warmth; drop the competitive-pressure edge.

---

## ✅ Pixel-verified — challenges, badges & social (founder pull, batch 3)

The **gamification core** — closer to Toofies' quest/streak mechanic than
anything Crumbl showed. This is the most important Strava batch for us.

### The challenge / badge loop (⭐ the key pattern)

- **Challenge cards** (Groups → Challenges): a **collectible hex/shield badge**
  (e.g. "5K", "100K", "10x", "7000M", "400'"), title, one-line goal, date range,
  and an **orange "Join" pill**. Categorized ("Recommended for You / Based on
  your activities", "Active Challenges" as circular badge progress rings).
- **Challenge detail:** hero image/video (or brand art), the badge, a
  **"Joined" chip**, goal description, and a **progress bar** with state:
  *"28 days left"* / *"1 day left"* (in progress) → **green filled bar +
  "Completed"** when done. On completion, a **"Share achievement"** CTA
  (orange outline pill). Some end in a real reward ("two weeks free of Runna").
- **Badges are the collectible currency of achievement** — earned, kept, shown.
  Directly analogous to Toofies **milestone / "Sweet Toofies" collectibles.**

### The semantic color system (now fully visible)

Strava uses **three** functional colors against a black/white/gray shell:
- **Orange** = action/energy (Join, Pause, active tab, live route).
- **Gold** = personal achievement (PR badges, the Local-Legend crown/laurel).
- **Green** = completion (the "Completed" progress bar).
This *three-signal* system (act / achieve / complete) is a clean model Toofies
could mirror (our hues TBD): one accent to act, one to celebrate, one for done.

### Social / competitive (⚠️ the opt-in, handle-with-care layer)

- **Leaderboards** (challenge + segment "Local Legend"): rank · athlete ·
  metric, **crown for #1 (CR)**, laurel for the Legend, tabs "Overall /
  Following". A **privacy note** ("only activities visible to Everyone count…").
- **Clubs / Groups / Events**, "Create Your Own Club", "Design Your Own
  Challenge — your game, your rules", "Invite Friends".
- For Toofies this is the **long-term, opt-in social vision** — and the clearest
  place our **behavioral safeguards** bite: leaderboards manufacture competitive
  pressure. Any Toofies social must stay opt-in, non-ranking, non-coercive.

### Maps / discovery hub

- A tile grid: **Create a Route · Heatmaps · Flyover · Offline Routes**;
  photo-card **"Suggested Routes / Made for you"**; filter chips (Length /
  Elevation / Surface / Difficulty); a **premium paywall** ("Explore anywhere
  with confidence · Start a free trial", lock icon). Reference for our future
  **dessert-place discovery** (not the paywall — Toofies pricing is undecided).

### → Toofies mapping (gamification)

| Strava pattern (observed) | Toofies equivalent |
|---|---|
| Challenge card (badge + goal + Join) | **Daily step quest / limited-time gentle challenges** |
| Progress bar → green "Completed" | **Points-toward-dessert** + a "done" state |
| Collectible achievement badges | **Milestone / Sweet-Toofies collectibles** |
| "Share achievement" | **Optional** social share (long-term vision, opt-in) |
| 3-color system (orange/gold/green) | act / celebrate / complete signals (hues TBD) |
| Circular badge progress rings | Echoes our canonical **completion ring** |
| Leaderboards / Local Legend crown | **Deferred, opt-in social** — never ranking-by-default (safeguard) |
| Maps hub + "Made for you" cards | Future dessert-place **discovery** |

**Behavioral-safeguard check:** Strava's challenge/badge/progress loop is the
*good* gamification (personal goals, collectible wins, completion joy) — adopt
it. Its leaderboard/competition layer is the *pressure* Toofies exists to avoid
— gate it behind explicit opt-in and never rank users against each other by
default.

---

## ✅ Pixel-verified — profile, streaks & safety (founder pull, batch 4)

The personal-progress home + the safety/moderation toolkit. Two things here are
direct validation and one is a template for our safeguards.

### Profile / "You" — the personal-progress home (⭐)

- **Header:** orange-shield avatar + name + "SUBSCRIBER SINCE …" + short bio.
- **Stat row:** Following · Followers · Activities · **Weekly Streak: 76.**
  → **A major health app makes a STREAK a headline stat.** Direct validation of
  the Toofies days-on-plan streak as a first-class number.
- **Media strip** (recent photos), sport filter chips (All Ride/Run/Walk…).
- **"This week"** block: Distance / Time / Elevation + an **orange line+area
  trend chart** across months (Apr→Jun), with the latest point emphasized and a
  peak value labeled ("18 km"). → maps to Toofies **steps/points-over-time**.
- **"You" hub list:** Activities · Statistics ("This year: 396.8 km") · Routes ·
  Segments · Best Efforts · Posts — a clean icon+label+count menu.
- **Trophy Case (152):** a **collectible badge gallery** ("1000th Activity",
  monthly challenge medals) with a count + "All trophies". → Toofies
  **milestone collectibles gallery.**
- **Best Efforts:** a **gold PR medal with a sunburst** for #1, **silver/bronze**
  medals for 2nd/3rd, filter chips (400m/1K/1mile). Achievement *tiers*.

### Safety / moderation toolkit (⭐ template for our LOCKED safeguards)

- **Follow menu (bottom sheet):** Add to **Favorites** (orange star, "top of
  your Feed") · **Turn on Notifications** · **Mute** ("won't let them know") ·
  Unfollow · Report activity.
- **Block flow:** a plain-language **"Blocking an Athlete will…"** consequence
  list → Cancel / **Block Athlete**; blocked state banner on the profile.
- **Report → anonymous confirmation** ("your report will remain anonymous…
  keep Strava safe and fun").
- **First-DM guideline nudge:** before messaging, a **Community Guidelines**
  reminder ("be respectful… keep Strava positive") + a friendly mascot.
- This is exactly the *responsible* social toolkit any opt-in Toofies community
  layer would need — mute/block/report + positive-behavior nudges, privacy-first.

### Friend discovery

- Search people; tabs **Suggested / Contacts / QR Code**; **"Connect Securely"**
  contacts framing; personal **QR code + Copy Link**; Invite. Privacy-aware
  social-graph building — reference for the long-term (opt-in) social vision.

### → Toofies mapping (profile & safety)

| Strava pattern (observed) | Toofies equivalent |
|---|---|
| "Weekly Streak: 76" headline stat | **Days-on-plan streak** as a first-class profile number |
| "This week" + orange trend chart | **Steps/points-over-time** on the Toofies profile |
| Trophy Case (collectible badges + count) | **Milestone / Sweet-Toofies collectibles gallery** |
| Best Efforts gold/silver/bronze tiers | Tiered personal achievements (non-competitive) |
| "You" hub (icon+label+count list) | Toofies profile/settings hub |
| Mute / Block / anonymous Report | **Required** safety toolkit for any opt-in social |
| First-DM Community-Guidelines nudge | Positive-behavior framing (fits non-punitive brand) |
| QR / Contacts "Connect Securely" | Privacy-first friend discovery (long-term, opt-in) |

**Behavioral-safeguard check:** the profile's *personal* progress (streak,
trend, trophies) is pure Toofies fuel — adopt it. The social/safety toolkit is
the model for doing an opt-in community *responsibly* (mute/block/report,
positive nudges) — if/when Toofies ships social, this bar is the minimum.

---

## ✅ Pixel-verified — milestones, dataviz, empty states & kudos (batch 5)

The final batch. Three of these are directly reusable for Toofies.

### ⭐ Locked/unlocked milestone progression (Trophy Case detail)

The Trophy Case "Milestones" grid shows **earned badges in full color** (blue
hex + orange rim: "First Activity", "Third Activity") and **not-yet-earned ones
grey with a padlock** ("Fifth / 10th / 20th / 30th Activity"). Below, a
year section lists earned challenge medals. **This is precisely the Toofies
streak-milestone model** (3, 7, 10, 14, 21, 30, 50…): a collectible ladder you
progressively unlock — visible future goals + a satisfying "earned" state.

### Warm, encouraging empty / first-time states (⭐ on-brand for us)

- Best Efforts (no data): **"No PR — Yet!" → "Put your Best Effort forward."**
  with the medal podium art (gold/silver/bronze) as an aspirational preview.
- Starred Segments (empty): friendly copy + a route illustration + **"Explore
  Segments"**. Never a dead-end; always a gentle next step. → Toofies empty
  states (no desserts logged, no streak yet) should feel this warm.

### Statistics — tiered breakdown

Per-sport tabs (run/ride/swim) → **Activity (avg/week)**, **Year-to-date**,
**All time** sections, each a label→big-value row list. Clean model for a
Toofies stats page (clean days, treats, steps by week/YTD/all-time).

### Dataviz (two strong references)

- **Workout Analysis:** vertical **pace bars over a ghosted gray elevation
  band**, with a **dashed average line** — pace-per-segment at a glance.
- **Splits table:** `Km · Pace (horizontal bar) · Elev · HR` — a compact
  bar-in-table pattern. Both are great references for a Toofies
  **steps/clean-days-per-week** chart (see `dataviz` skill when we build it).

### Kudos & comments (the opt-in social interaction)

Activity discussion: **orange thumbs-up "kudos" (171)** + a row of kudoer
avatars, threaded comments, **swipe-to-Delete** + **Confirm Delete** on your own
comment, "Add a comment / Send" bar. Warm, lightweight social. → the long-term,
**opt-in** Toofies social layer (share a milestone, cheer a friend) — never
default-on, always safeguarded.

### Onboarding arc (for reference)

Complete profile (photo upload) → **"It's not always a solo sport"** suggested
follows (framed as *"kudos, encouragement, motivation"* — not competition) →
**"That's it, thanks!"** completion with "update anytime". A gentle,
motivation-first arc — good model tone for a Toofies first-run.

### → Toofies mapping (final)

| Strava pattern (observed) | Toofies equivalent |
|---|---|
| Locked/unlocked milestone badge grid | **Streak-milestone ladder** (3/7/10/… as unlockable collectibles) |
| "No PR — Yet!" warm empty state | Encouraging Toofies empty states (never a dead-end) |
| Statistics tiers (avg/week · YTD · all-time) | Toofies stats page (clean days / treats / steps) |
| Pace-bars-over-elevation + dashed avg | Steps/clean-days weekly chart (dataviz) |
| Splits bar-in-table | Compact per-day/per-week metric table |
| Kudos + comments (swipe-delete) | Opt-in social: cheer a friend's milestone |
| "It's not always a solo sport" onboarding | Motivation-first first-run (opt-in social framed as encouragement) |

**Behavioral-safeguard check:** the milestone ladder, warm empty states, and
personal dataviz are core Toofies fuel — adopt directly. Kudos/comments are the
*gentle* end of social (encouragement, not ranking) — adopt them for the opt-in
layer, keep the safeguards (mute/block/report, no default-on, no leaderboards).

---

## ✅ Pixel-verified — home streak, goals, onboarding & privacy (batch 6)

The home feed + celebration + privacy. **The most directly reusable batch for
Toofies** — several of these are near-specs for our screens.

### ⭐⭐ "Your streak" home widget (near-spec for Toofies' home)

A pinned home card: a **big orange flame + "1 Weeks"**, then a **week row
(M T W T F S S)** where **completed days are filled black circles with a shoe
glyph**, the in-progress day has an **indicator dot**, and future days are empty
outlined circles. A **"Share"** button top-right; swipeable to other snapshots.
**This is almost exactly the Toofies days-on-plan streak home** — swap shoe→🦷,
completed = clean/earned day. Adopt this pattern closely.

### ⭐ Goals as green completion rings

"Goals / Add a Goal": circular **green progress rings** — "8.5 km · 5.0 km/week",
"3 · 2/week" — a shoe glyph in the center. Also a "Suggested Goal · 1h per week
· 0m/1h · Set Goal" card. → Toofies weekly goals + reuses our **completion-ring**
canonical pattern (green = on track).

### ⭐ Onboarding checklist (gamified first-run)

**"You've joined the world's largest team! Here's how to get started"** with a
**0/4 progress bar** and check-off rows: *Upload your first activity · Follow
three people (0/3) · Add a profile picture · Connect a device* (each a card with
icon + title + subtitle + chevron; some with inline CTAs "Connect / I don't have
one"). A later state: **"You're set – let's keep moving. 4/4"** with green bars.
→ a warm, gamified Toofies first-run checklist (log first dessert, set your mode,
connect Health…).

### ⭐ Challenge-complete celebration modal

A full **"Congratulations! You completed June 5K x Brooks Challenge!"** modal —
big collectible badge, **Details** (orange pill) + **Share achievement** (orange
outline). → the **Sweet-Toofies milestone celebration** moment (streak hit,
quest done) — big badge, celebrate, optional share.

### ⭐ Privacy / visibility controls (model for our LOCKED safeguards)

Edit Activity → **Visibility "Who can view": Everyone / Followers / Only You**,
each with a plain-language explanation of exactly what's exposed (leaderboards,
summaries, fully private). Plus **Hidden Details** (hide Calories / Pace / Start
time), **Mute Activity** ("don't publish to feeds, still on your profile"),
**private notes** ("only you can see these", lock icon), per-activity delete.
→ **This granular, plain-language, private-by-choice model is exactly what
Toofies needs** given the founder's data-collection concern: default-private,
user controls every exposure, nothing shared without an explicit choice.

### Also captured (lower priority)

- **Weekly Snapshot** — Activities/Time/Distance tiles with **▲ delta**
  indicators; "See More".
- **Instant Workouts** — an **Easier / Steady / Harder / Variety** focus
  selector ("Your focus: Stay active") + swipeable gradient workout cards with
  time/difficulty; encouraging, non-punitive copy ("keep your consistency…").
- **Athlete Intelligence** — AI insight cards ("You crushed three personal
  bests…", "Say More") — gentle AI coaching (Toofies could offer supportive,
  never-shaming AI notes).
- **Muscle-group heatmap** (weight training), **body-map** viz.

### → Toofies mapping (home & privacy)

| Strava pattern (observed) | Toofies equivalent |
|---|---|
| "Your streak" flame + week-circles + Share | **Days-on-plan streak home widget** (near-spec) |
| Green goal completion rings | Weekly goals via our **completion-ring** pattern |
| 0/4 onboarding checklist | Gamified Toofies first-run checklist |
| Challenge-complete celebration modal | **Sweet-Toofies** milestone celebration |
| Everyone/Followers/Only-You + Hidden Details | **Default-private** granular privacy controls (safeguard) |
| Weekly Snapshot with ▲ deltas | Toofies week-over-week snapshot |
| Instant Workouts focus selector | Gentle activity suggestions ("stay active", non-punitive) |
| Athlete Intelligence AI cards | Supportive, never-shaming AI notes |

**Behavioral-safeguard check:** the streak widget, goal rings, onboarding
checklist, and celebration modal are near-ready Toofies patterns — adopt them.
The **privacy model is the headline takeaway**: private-by-default, per-item
visibility with plain-language consequences, and the ability to hide specific
metrics — the exact answer to the founder's earlier "isn't that data
collection?" concern. Toofies should meet or exceed this bar.

### Two final additions

- **Empty-state streak** — before any activity: "Your streak · **0 Weeks** ·
  Start your streak by logging an activity" + "Record now" + "View calendar".
  The same widget, warm zero-state. → Toofies pre-streak home.
- **⭐ Beacon (opt-in safety location sharing).** "Share a Beacon with up to
  **three safety contacts** so they can see your location during your activity."
  Toggle per device, a message field, contact picker (max 3), and an **explicit
  consent dialog** ("Allow Strava to Share Your Location?" spelling out exactly
  what's shared and its limits). This is the **responsible model for the
  founder's location-sharing vision**: strictly opt-in, capped, explicit
  consent, safety-framed — never broadcast, never default-on. If Toofies ever
  does location, this is the bar.

### ⭐ Question-first onboarding arc (full flow)

A motivation-first signup arc, mostly multi-select/single-select big rows:
- **"What do you plan to use Strava for?"** (multi): Compete · Explore ·
  **Maintain my health** · Connect · Train for a goal · **Build an exercise
  habit** — selected rows flip to black + a subtitle appears. Captures *intent*
  first. → Toofies day-1: "why are you here?" (be mindful about dessert / build
  a habit / just track recency).
- **"Where are you in your fitness journey?"** (Beginner→Pro, each with a
  plain-language self-description).
- **"What types of activities do you like to do?"** — an icon-card **sport grid**
  (multi-select, selected = black).
- **Identity, minimally & respectfully:** gender (incl. **"Prefer not to say ·
  won't appear on your profile"**) and birthday (**"won't appear… to keep
  younger users safe"**) — each states *why it's asked* and *that it stays
  private*. A good model for asking as little as possible, with a reason.
- **⭐ "Custom privacy options for almost everything"** — a dedicated
  onboarding screen: *"We care about your safety… we'll **hide the start and
  ends of your activities by default**… customize **12+ privacy controls**."*
  Private-by-default, safety-framed, surfaced *during* onboarding — not buried.
- Warm welcome bookends ("You're in good company", "Welcome, Sam!") + a
  notification-permission primer ("Choose permissions").

**Toofies takeaway:** open with *motivation* (mindfulness/habit), ask the
minimum, explain every field, and put **privacy front-and-center in onboarding**
— exactly the posture the founder wants.
