# Focuset

Blurs and dims everything except the windows you are working in. A free macOS menu-bar app for macOS 14 or newer (Apple silicon and Intel).

**Download:** [Focuset.dmg](https://github.com/janvodvarka/focuset-releases/releases/latest/download/Focuset.dmg) (always the latest version)

**Install with one line** (no Gatekeeper prompt, files fetched by curl are not quarantined):

```
curl -fsSL https://raw.githubusercontent.com/janvodvarka/focuset-releases/main/install.sh | bash
```

**Or with Homebrew:**

```
brew install --cask janvodvarka/tap/focuset
```

**Or by hand:** open the DMG and drag Focuset to Applications. Focuset is not notarized by Apple, so the first launch needs one approval: **System Settings › Privacy & Security › Open Anyway**.

Then allow Focuset in **Privacy & Security › Accessibility** when it asks.

Focuset checks for updates once a day and asks before installing a new version (Sparkle, EdDSA-signed updates). No account, no analytics.

This repository only hosts the installers and the update feed (`appcast.xml`).
