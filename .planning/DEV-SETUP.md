# Toofies — Local Development Setup (your Mac)

**Yes, we need this — it's not optional for iOS.** Xcode (the tool that builds
and runs an iPhone app) only exists on macOS. This cloud environment is great
for planning, writing code, and research, but it **cannot build or run the
app** — no Mac, no Xcode. Your Mac is the "local base" where the app actually
becomes a tappable thing, gets tested, and is eventually submitted to the App
Store. The repo is the shared source of truth; you pull it down locally.

## One-time setup

1. **Install Xcode** — free from the Mac App Store (it's large, ~7–15 GB; let
   it finish). We need **Xcode 16 or newer**. Open it once and let it install
   the additional components it asks for.
2. **Command Line Tools** (git, etc.) usually come with Xcode. If `git` isn't
   found in Terminal, run: `xcode-select --install`.

## Get the code onto your Mac

Pick one:

- **Terminal:**
  ```
  cd ~/Developer        # or wherever you keep projects (mkdir -p ~/Developer)
  git clone https://github.com/market-theory/thetoofiesapp.git
  cd thetoofiesapp
  open Toofies.xcodeproj
  ```
- **GitHub Desktop** (if you prefer no terminal): "Clone a repository" →
  `market-theory/thetoofiesapp` → then open `Toofies.xcodeproj` in Xcode.

## Run it

1. In Xcode, select the **Toofies** scheme (top bar) and a simulator (e.g.,
   **iPhone 16**).
2. **Signing:** click the project → **Signing & Capabilities** → check
   "Automatically manage signing" and pick your **Team** (your free Apple ID
   works for running on the simulator and your own device; the $99 Apple
   Developer Program is only needed later for TestFlight / the App Store).
3. Press **Run (⌘R)**. First build compiles the app and launches the simulator.

## Expect a few first-build fixes

This code has **never been compiled** (it was all written in the cloud). The
first build may flag small issues — most likely around the HealthKit code
(`StepSyncService`, entitlements) or Swift Charts. That's normal for a
never-built project. Paste any Xcode errors back to me and I'll fix them.

## How the cloud and your Mac work together

- The **repo on GitHub** (`market-theory/thetoofiesapp`) is the single source
  of truth. Cloud sessions and your Mac both push/pull to it.
- Typical loop: I make changes in the cloud and push → you `git pull` on your
  Mac and build/run → you paste back errors or feedback → repeat.
- Optional: you can also run **Claude Code in your Mac's Terminal** (`claude`
  in the repo folder) so a local assistant can build and run directly. Same
  repo, same `CLAUDE.md` rules.

## What the local base unblocks

- The **first real build** (the top open task in `SESSION-STATE.md`).
- **Testing** on the simulator and your own iPhone.
- **Cross-model code review via Codex** (runs locally, per `CLAUDE.md`).
- Eventually **archiving + uploading to TestFlight / the App Store**
  (`APP-STORE-SUBMISSION.md`) — all done from Xcode on your Mac.
