# Toofies — App Store Submission Guide (first-timer edition)

Everything needed to get Toofies from Xcode onto the App Store, in order. This
is written for someone doing it for the first time. Nothing here needs to be
memorized — work top to bottom when you're ready to ship. Items marked
**[blocker]** must exist before Apple will accept the build.

> Verify specifics against the live source before submitting — Apple changes
> requirements. Authoritative pages:
> App Review Guidelines <https://developer.apple.com/app-store/review/guidelines/>,
> Screenshot specs <https://developer.apple.com/help/app-store-connect/reference/screenshot-specifications/>,
> HIG app icon <https://developer.apple.com/design/human-interface-guidelines/app-icons>.

---

## 0. The one-time accounts & money

- **[blocker] Apple Developer Program membership — $99/year.** Enroll at
  <https://developer.apple.com/programs/>. Individual is fine (your name shows
  as seller) or set up an LLC and enroll as an Organization (needs a D-U-N-S
  number, ~free, takes days). Do this first — enrollment can take 24–48h.
- A **Mac with Xcode 16+** (required to archive/upload; there is no way around
  owning a Mac or a Mac cloud service).
- An **Apple ID** with two-factor auth for App Store Connect
  <https://appstoreconnect.apple.com>.
- **Tax & banking** in App Store Connect → Agreements. Even for a free app you
  must accept the Paid/Free Apps agreement. For paid/subscription you must
  complete tax forms and banking before anything can sell.

## 1. Identifiers & signing (Xcode does most of this)

- **[blocker] Bundle ID** — currently `us.of-course.toofies`. Register it under
  Certificates, Identifiers & Profiles, and **enable the HealthKit capability**
  on the App ID (we read step data).
- **Signing:** in Xcode → Toofies target → Signing & Capabilities, check
  "Automatically manage signing" and pick your Team. Xcode creates the
  certificate + provisioning profile. Confirm **HealthKit** is listed under
  Capabilities (our `Toofies.entitlements` already declares it).
- **Version & build:** Marketing Version `1.0`, Build `1` (already set). Every
  upload needs a unique build number; bump Build for each new upload of the
  same version.

## 2. Required assets

### 2a. App icon **[blocker]**
One **1024×1024 px** PNG, no alpha, no transparency, sRGB, square (Apple
rounds the corners). Xcode 16 accepts the single 1024 "single size" slot in
the asset catalog (`Assets.xcassets/AppIcon`) and generates the rest.
- Design direction is **undecided** (see `DESIGN-SPEC.md`) — the icon follows
  from the brand decision, so it must read at small sizes, have no text, and
  keep safe margins, but no colors/motif are chosen yet.
- *Status: placeholder appiconset exists but is empty — a real 1024 icon is a
  hard blocker once the brand direction is set.*

### 2b. Launch screen
A launch screen is required. We use the generated storyboard
(`INFOPLIST_KEY_UILaunchScreen_Generation = YES`) — a plain background is
fine; the exact background follows the (undecided) brand direction. No splash
marketing (HIG forbids splash ads).

### 2c. Screenshots **[blocker]**
Uploaded per device size in App Store Connect. As of 2025 Apple requires, at
minimum:
- **6.9" iPhone** (e.g. 15/16 Pro Max) — **1290×2796 px** (portrait). **[blocker]**
- **6.5" iPhone** (older Pro Max) — 1242×2688 or 1284×2778 — often still
  requested; provide if prompted.
- **iPad 13"** — 2064×2752 (only if you ship iPad; our target is Universal, so
  **yes** — either provide iPad shots or set the app to iPhone-only to avoid
  the requirement).
- 1–10 shots per size, PNG/JPG, no alpha. First 1–3 matter most (they show in
  search). Capture from the iOS Simulator (Cmd+S saves at exact spec size).
- **Recommendation:** to cut screenshot burden, consider setting
  `TARGETED_DEVICE_FAMILY = 1` (iPhone-only) for v1 unless iPad is a real
  goal — it removes the iPad screenshot + iPad-QA requirement.

### 2d. App preview video — optional (skip for v1).

## 3. Privacy — the part most first-timers trip on **[blocker]**

Because Toofies uses **HealthKit**, this gets extra scrutiny.

- **[blocker] Usage string:** `NSHealthShareUsageDescription` — already set:
  "Toofies reads your daily step count so being active can earn you dessert
  points." Must be specific and truthful (generic strings get rejected).
- **[blocker] Privacy Nutrition Label** (App Store Connect → App Privacy):
  declare what the app actually collects. **This depends on an architecture
  decision that is NOT yet made** (see the "Privacy hinges on accounts"
  callout below). Two very different answers:
  - **On-device / no-account build (what exists today):** nothing is
    transmitted — no server, account, analytics, or tracking — so **"Data Not
    Collected"** is accurate *for this build*, and is the strongest possible
    privacy posture. This label is only honest as long as the app stays this
    way.
  - **Accounts / social / cloud build:** opting in with an email, Sign in with
    Apple, a profile, friends/feeds, or cloud sync **is** collecting personal
    data (email, name, user content, identifiers). The label must then list
    every category, and the obligations in the callout below apply.
- **[blocker] Privacy Manifest** (`PrivacyInfo.xcprivacy`): Apple now requires
  a privacy manifest declaring "required reason" API usage. We use
  `UserDefaults` (reason code `CA92.1`) and read HealthKit. *Status: not yet
  in the project — needs to be added before submission. I can generate it.*
- **HealthKit rules (App Review Guideline 5.1.3):** you may **not** use Health
  data for advertising, marketing, or sale to third parties; may not store it
  in iCloud/third-party clouds. We do none of these — but the reviewer may ask,
  so the review notes (§6) should state it plainly.
- A **privacy policy URL is required** (even for "collects nothing"). A simple
  hosted page suffices. *Needs writing + hosting.*

### Privacy hinges on one decision: accounts or not? **[UNDECIDED]**

The founder's social/sharing vision ("share your desserts") pulls toward
accounts; the current app and the privacy-as-a-feature posture pull toward
staying on-device. This is a genuine fork, not yet decided.

- **Payment info — you almost certainly never hold it.** Apple *requires*
  digital subscriptions/unlocks to use In-App Purchase. Apple is the merchant
  of record: they process and hold the card data; you get payouts + anonymized
  sales reports, never names/addresses/card numbers. So a *paid* Toofies can
  still be "Data Not Collected." (Only physical goods / real-world services
  would put you in scope, via Apple Pay/Stripe — not relevant to a dessert
  tracker.)
- **Names / emails** — collected only if you add sign-up or Sign in with Apple.
- **Location / phone / address** — collected only if a feature requests them; a
  dessert tracker needs none by default. (Location only if we build the
  "geotag your dessert" idea.)
- **If you go the accounts route, the obligations are real:** full privacy-label
  disclosure; a detailed privacy policy; GDPR (EU) + CCPA (California)
  compliance; **Apple requires in-app account deletion** if you offer account
  creation; secure backend + breach liability; and App Tracking Transparency
  if you ever track users across other apps/sites.

**Recommendation to consider (not a decision):** ship v1 on-device / no-account
(fast, "Data Not Collected," no legal surface), and treat accounts + social as
a deliberate v2 with its own privacy/compliance workstream. Your call.

## 4. App Store Connect listing (metadata)

Create the app record in App Store Connect (+ → New App), then fill:
- **Name** (30 chars): "Toofies". **Subtitle** (30): e.g. "Earn your desserts".
- **[blocker] Primary category:** Health & Fitness (Secondary optional, e.g.
  Lifestyle).
- **[blocker] Age rating** questionnaire → Toofies should land **4+** (no
  objectionable content). Answer honestly; "Infrequent/Mild"? all No.
- **Description**, **Keywords** (100 chars, comma-separated, no spaces),
  **Promotional text** (170, updatable without review), **Support URL**
  **[blocker]** and Marketing URL (optional).
- **Privacy Policy URL** **[blocker]** (see §3).
- **Pricing:** Free for v1 (matches PRODUCT.md — no paywall yet). If/when we
  add Pro, that's In-App Purchases configured here + StoreKit in the app.
- **Content Rights**, **Export Compliance:** we use only standard
  encryption (HTTPS/none) → set `ITSAppUsesNonExemptEncryption = NO` in Info
  (a one-line Info.plist key) to skip the export-compliance prompt on every
  upload.

## 5. Build → upload → TestFlight

1. In Xcode: set the run destination to **Any iOS Device (arm64)** (not a
   simulator — you can't archive for the store from a simulator).
2. **Product → Archive.** When it finishes, the Organizer opens.
3. **Distribute App → App Store Connect → Upload.** Xcode validates, signs,
   and uploads. Processing on Apple's side takes ~5–30 min.
4. The build appears in App Store Connect → TestFlight. **Test it there first**
   (install via the TestFlight app on your iPhone) — this is where you catch
   the HealthKit permission prompt, real step data, and the widget on a real
   Home Screen.
5. First external TestFlight testing needs a quick **Beta App Review**;
   internal testing (your own account) does not.

## 6. Submit for review

- Attach the build to the version, add the **screenshots** and metadata.
- **App Review notes** — write these to pre-empt rejection:
  - "All data is stored on-device (UserDefaults); no account, server, or
    analytics. Privacy label = Data Not Collected."
  - "HealthKit: read-only step count, used solely to award in-app points.
    Never used for advertising and never transmitted off device."
  - "No login required — reviewer can use all features immediately."
- **No demo account needed** (no login). 
- Submit. Review is typically 24–48h. If rejected, Apple cites the guideline;
  most first-time rejections are metadata/privacy-string issues, all fixable
  without a new build.

## 7. Likely rejection risks for *this* app (front-load the fixes)

| Risk | Guideline | Mitigation |
|---|---|---|
| Vague HealthKit usage string | 5.1.1 | Ours is specific ✓ |
| HealthKit data misuse claim | 5.1.3 | Review notes state on-device-only ✓ |
| Missing Privacy Manifest | — | **Add `PrivacyInfo.xcprivacy`** (todo) |
| Weight-loss / health claims | 1.4.1 / medical | PRODUCT.md bans calorie/weight/medical framing ✓ — keep copy playful, never claim health outcomes |
| "Minimum functionality" / feels thin | 4.2 | v1 must feel complete: onboarding + widget + polish (in progress) |
| Placeholder icon / screenshots | 2.3 | Real 1024 icon + real screenshots (todo) |
| Reduce Motion not respected | accessibility | Celebration bursts must honor Reduce Motion (in spec) |

## 8. Pre-submission checklist (run this the day you ship)

- [ ] Apple Developer membership active; agreements signed
- [ ] Real 1024×1024 app icon in the asset catalog
- [ ] `PrivacyInfo.xcprivacy` added (UserDefaults + HealthKit reasons)
- [ ] Privacy policy hosted; URL in App Store Connect
- [ ] Screenshots for every required device size (or iPhone-only target)
- [ ] `ITSAppUsesNonExemptEncryption = NO` set
- [ ] App Privacy = Data Not Collected
- [ ] HealthKit capability on App ID + entitlement in build
- [ ] Tested on a real device via TestFlight (Health prompt, steps, widget)
- [ ] Reduce Motion + largest Dynamic Type verified
- [ ] Review notes written (on-device, HealthKit read-only, no login)
- [ ] Version 1.0 / Build unique

---

### What I can generate for you next (just ask)
- First-draft **1024 app icon** (tooth + dessert on amber).
- **`PrivacyInfo.xcprivacy`** manifest, ready to drop in.
- A **privacy policy** page (Markdown/HTML) you can host.
- The **App Store listing copy** — name, subtitle, description, keywords,
  promo text — tuned for ASO and the "earn your desserts" hook.
- The `ITSAppUsesNonExemptEncryption` Info key wired into the project.
