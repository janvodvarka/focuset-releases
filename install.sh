#!/bin/bash
# Installs or updates Focuset from the latest public release:
#   curl -fsSL https://raw.githubusercontent.com/janvodvarka/focuset-releases/main/install.sh | bash
# Files fetched by curl carry no quarantine flag, so macOS opens Focuset
# without the Gatekeeper prompt. Updates then arrive inside the app.
set -euo pipefail
URL="https://github.com/janvodvarka/focuset-releases/releases/latest/download/Focuset.dmg"
APPDIR="${FOCUSET_APPDIR:-/Applications}"
APP="$APPDIR/Focuset.app"
WORK="$(mktemp -d)"
MOUNT="$WORK/volume"
trap 'hdiutil detach -quiet "$MOUNT" 2>/dev/null || true; rm -rf "$WORK"' EXIT

echo "Downloading Focuset…"
curl -fL --progress-bar -o "$WORK/Focuset.dmg" "$URL"
hdiutil attach -nobrowse -readonly -quiet -mountpoint "$MOUNT" "$WORK/Focuset.dmg"

# Quit an older copy running from the same place before replacing it.
if pgrep -f "$APP/Contents/MacOS/Focuset" >/dev/null; then
  echo "Quitting the running Focuset…"
  osascript -e 'quit app id "app.focuset.mac"' >/dev/null 2>&1 || true
  for _ in $(seq 20); do pgrep -f "$APP/Contents/MacOS/Focuset" >/dev/null || break; sleep 0.5; done
  pkill -f "$APP/Contents/MacOS/Focuset" 2>/dev/null || true
fi

SUDO=""
[ -w "$APPDIR" ] || SUDO="sudo"
$SUDO rm -rf "$APP"
$SUDO ditto "$MOUNT/Focuset.app" "$APP"
$SUDO xattr -dr com.apple.quarantine "$APP" 2>/dev/null || true
echo "Installed Focuset $(defaults read "$APP/Contents/Info" CFBundleShortVersionString) in $APPDIR"
[ "${FOCUSET_NO_OPEN:-}" = 1 ] || open "$APP"
