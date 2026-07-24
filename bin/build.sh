#!/usr/bin/env bash

set -eu

PWD=$(pwd)
TIMESTAMP="${TIMESTAMP:-$(date -u +"%Y%m%d%H%M")}"
COMMIT="${COMMIT:-xxxxxx}"

# Targets mirror build.yaml: nice_nano_v2 board, shield passed per side.
# Studio snippet goes on the right half (the trackball/central side).

# West Build (left)
west build -s zmk/app -p -d build/left -b nice_nano_v2 \
    -- -DSHIELD="keyball44_left nice_view_adapter nice_view" -DZMK_CONFIG="${PWD}/config"
grep -vE '(^#|^$)' build/left/zephyr/.config
cp build/left/zephyr/zmk.uf2 "./firmware/${TIMESTAMP}-${COMMIT}-keyball44-left.uf2"

# West Build (right, with ZMK Studio support)
west build -s zmk/app -p -d build/right -b nice_nano_v2 -S studio-rpc-usb-uart \
    -- -DSHIELD="keyball44_right nice_view_adapter nice_view" -DZMK_CONFIG="${PWD}/config"
grep -vE '(^#|^$)' build/right/zephyr/.config
cp build/right/zephyr/zmk.uf2 "./firmware/${TIMESTAMP}-${COMMIT}-keyball44-right.uf2"

# Settings reset image (flash to both halves to clear pairing state)
if [ "${BUILD_SETTINGS_RESET:-false}" = true ]; then
    west build -s zmk/app -p -d build/reset -b nice_nano_v2 \
        -- -DSHIELD=settings_reset -DZMK_CONFIG="${PWD}/config"
    cp build/reset/zephyr/zmk.uf2 "./firmware/${TIMESTAMP}-${COMMIT}-settings-reset.uf2"
fi
