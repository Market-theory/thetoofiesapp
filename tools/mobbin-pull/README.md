# Mobbin puller (run on your Mac)

Automated Mobbin screen capture into the Toofies design library. Runs locally
where the network is open and you're logged into Mobbin.

## Setup (once)
```
cd tools/mobbin-pull
npm install          # installs Playwright + Chromium
```

## Log in (once)
```
node pull.mjs strava "https://mobbin.com/apps/strava-ios-.../screens"
```
A browser window opens. If it shows a Mobbin login, sign in, then press Enter
in the terminal. Your session is saved to `.mobbin-profile/` for next time.

## Pull any app
```
node pull.mjs <app-name> "<mobbin screens or flows URL>"
```
Screens save to `.planning/design-library/<app-name>/screens/`. Commit them,
or tell Claude they're there and it will catalog them into the library.
