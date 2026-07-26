# MochuKeeb Keyball44 Firmware

ZMK firmware for the MochuKeeb Keyball44.

## Branches

This repository intentionally has no `main` or `master` branch. Choose the branch
that matches the display installed on the keyboard:

| Branch | Display |
| --- | --- |
| [`niceview`](https://github.com/mochukeeb/zmk-config-Keyball44/tree/niceview) | nice!view |
| [`oled`](https://github.com/mochukeeb/zmk-config-Keyball44/tree/oled) | OLED |

Do not flash firmware from the other display branch.

## Local builds

Local builds require GNU Make and either Docker or Podman. To use the
optional [nice-view-keyball](https://github.com/apackeer/nice-view-keyball)
display module, clone both repositories into the same parent directory:

```sh
git clone https://github.com/apackeer/Keyball44-ZMK.git
git clone https://github.com/apackeer/nice-view-keyball.git
make -C Keyball44-ZMK
```

The Makefile discovers the sibling module automatically. For another
checkout location, set `DISPLAY_MODULE` to an absolute path:

```sh
make DISPLAY_MODULE=/path/to/nice-view-keyball
```

Set `DISPLAY_MODULE=` to build with the stock `nice_view` shield instead.
Generated UF2 files are written to `firmware/`.
