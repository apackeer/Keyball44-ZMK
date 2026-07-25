#!/usr/bin/env bash

# Regenerate img/keymap.svg (+ img/keymap.png) from config/keyball44.keymap
# using keymap-drawer (https://github.com/caksoylar/keymap-drawer), the same
# tool mochukeeb used for their layout graphics. Run after any keymap change:
#
#   bin/draw_keymap.sh
#
# Requires uv (uvx) on PATH; keymap-drawer is fetched on demand. The PNG is
# rendered at 2x with rsvg-convert (brew install librsvg) when available.

set -eu
cd "$(dirname "$0")/.."

mkdir -p img
parsed=$(mktemp)
trap 'rm -f "$parsed"' EXIT

uvx --from keymap-drawer keymap parse -z config/keyball44.keymap > "$parsed"

# keymap-drawer has no bundled physical layout named "keyball44"; point it
# at the shield's devicetree physical layout instead.
sed -i '' '1s|.*|layout: {dts_layout: config/boards/shields/keyball_nano/keyball44.dtsi}|' "$parsed" 2>/dev/null \
    || sed -i '1s|.*|layout: {dts_layout: config/boards/shields/keyball_nano/keyball44.dtsi}|' "$parsed"

uvx --from keymap-drawer keymap draw "$parsed" > img/keymap.svg
echo "wrote img/keymap.svg"

if command -v rsvg-convert >/dev/null 2>&1; then
    rsvg-convert --zoom 2 img/keymap.svg -o img/keymap.png
    echo "wrote img/keymap.png"
else
    echo "rsvg-convert not found - skipped img/keymap.png (brew install librsvg)"
fi
