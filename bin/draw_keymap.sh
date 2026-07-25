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

uvx --from keymap-drawer keymap -c keymap_drawer.config.yaml parse -z config/keyball44.keymap > "$parsed"

# Post-process the parsed keymap:
# - Shifted glyphs only make sense where Shift is chordable, so strip the
#   shifted legends from every layer except the base (the keycode map that
#   adds them is global).
# - keymap-drawer has no bundled physical layout named "keyball44"; point it
#   at the shield's devicetree physical layout instead.
uvx --from keymap-drawer python - "$parsed" <<'PY'
import sys, yaml
path = sys.argv[1]
with open(path) as f:
    data = yaml.safe_load(f)
data["layout"] = {"dts_layout": "config/boards/shields/keyball_nano/keyball44.dtsi"}
for name, keys in data.get("layers", {}).items():
    if name == "QWRT":
        continue
    for key in keys:
        if isinstance(key, dict):
            key.pop("s", None)
with open(path, "w") as f:
    yaml.safe_dump(data, f, allow_unicode=True, sort_keys=False)
PY

uvx --from keymap-drawer keymap draw "$parsed" > img/keymap.svg
echo "wrote img/keymap.svg"

if command -v rsvg-convert >/dev/null 2>&1; then
    rsvg-convert --zoom 2 img/keymap.svg -o img/keymap.png
    echo "wrote img/keymap.png"
else
    echo "rsvg-convert not found - skipped img/keymap.png (brew install librsvg)"
fi
