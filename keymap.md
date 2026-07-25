# Keyball44 Keymap Plan

Scratch pad for planning layers and modifications. Edit freely - this file is
not compiled. Promote finalised changes into `config/keyball44.keymap`.

Source of truth: `config/keyball44.keymap`. This file mirrors the current
state so you can see what's there and plan what changes next.

## Layout legend

The Keyball44 is a 44-key split: each half has three 6-column rows, then a
thumb cluster. The LEFT thumb cluster is 5 keys (two on the bottom-row grid
plus three angled thumbs); the RIGHT cluster is 3 keys (two angled thumbs
plus the lone key beside the trackball). The trackball sits on the RIGHT
half where the missing thumb keys would be.

Key positions (matrix order, used by the HRM hold-trigger lists):

```
╭──────┬──────┬──────┬──────┬──────┬──────╮        ╭──────┬──────┬──────┬──────┬──────┬──────╮
│  0   │  1   │  2   │  3   │  4   │  5   │        │  6   │  7   │  8   │  9   │  10  │  11  │
├──────┼──────┼──────┼──────┼──────┼──────┤        ├──────┼──────┼──────┼──────┼──────┼──────┤
│  12  │  13  │  14  │  15  │  16  │  17  │        │  18  │  19  │  20  │  21  │  22  │  23  │
├──────┼──────┼──────┼──────┼──────┼──────┤        ├──────┼──────┼──────┼──────┼──────┼──────┤
│  24  │  25  │  26  │  27  │  28  │  29  │        │  30  │  31  │  32  │  33  │  34  │  35  │
╰──────┴──────┼──────┼──────┼──────┼──────┤        ├──────┼──────┼──────┴──────┴──[ball]──────╯
              │  36  │  37  │ 38 39 40    │        │   41 42     │  43  │
              ╰──────┴──────┴─────────────╯        ╰─────────────┴──────╯
                       (38-40 angled thumbs)        (41-42 angled, 43 by the trackball)
```

## Base layer (QWRT)

```
╭──────┬──────┬──────┬──────┬──────┬──────╮        ╭──────┬──────┬──────┬──────┬──────┬──────╮
│ TAB  │  Q   │  W   │  E   │  R   │  T   │        │  Y   │  U   │  I   │  O   │  P   │ BSPC │
├──────┼──────┼──────┼──────┼──────┼──────┤        ├──────┼──────┼──────┼──────┼──────┼──────┤
│ CAPS │A/GUI │S/ALT │D/CTL │F/SFT │  G   │        │  H   │J/SFT │K/CTL │L/ALT │;/GUI │  '   │
├──────┼──────┼──────┼──────┼──────┼──────┤        ├──────┼──────┼──────┼──────┼──────┼──────┤
│ LSFT │  Z   │  X   │  C   │  V   │  B   │        │  N   │  M   │  ,   │  .   │  /   │ RSFT │
╰──────┴──────┼──────┼──────┼──────┴──────┴──╮     ├──────┴───┬──┴───┬──┴──[ball]─────┬─────╯
              │ LGUI │SNIPE │ MOUSE  BSPC ESC│     │ ENTER SPC│      │      DEL       │
              ╰──────┴──────┤  ---   NUM  SCL│     │  ---  SYM│      │      UTIL      │
                            ╰─────────────────╯     ╰──────────╯      ╰────────────────╯
```

Thumb keys, tap / hold (matching the Adv360 feel):

| Position | Tap | Hold |
| --- | --- | --- |
| left 36 | LGUI | - |
| left 37 | - | SNIPE (slow trackball) |
| left 38 (first angled) | - | MOUSE |
| left 39 (middle angled) | Backspace | NUM |
| left 40 (inner angled) | Escape | SCROLL (trackball scrolls) |
| right 41 (inner angled) | Enter | - |
| right 42 (outer angled) | Space | SYM |
| right 43 (by trackball) | Delete | UTIL |

Homerow mods: GACS, ported from the Adv360 (urob timeless-HRM: balanced,
tapping-term 280, quick-tap 175, require-prior-idle 150,
hold-trigger-on-release, opposite-hand trigger positions only). Mods fire
on pause-then-reach-across; same-hand rolls always type letters.

## NUM (hold left-thumb Backspace)

```
╭──────┬──────┬──────┬──────┬──────┬──────╮        ╭──────┬──────┬──────┬──────┬──────┬──────╮
│      │  1   │  2   │  3   │  4   │  5   │        │  6   │  7   │  8   │  9   │  0   │      │
├──────┼──────┼──────┼──────┼──────┼──────┤        ├──────┼──────┼──────┼──────┼──────┼──────┤
│      │ LEFT │ DOWN │  UP  │RIGHT │      │        │      │      │      │      │      │      │
├──────┼──────┼──────┼──────┼──────┼──────┤        ├──────┼──────┼──────┼──────┼──────┼──────┤
│      │      │      │      │      │      │        │      │      │  ▽   │  ▽   │      │      │
╰──────┴──────┴──────┴──────┴──────┴──────╯        ╰──────┴──────┴──────┴──────┴──────┴──────╯
```

## SYM (hold right-thumb Space)

```
╭──────┬──────┬──────┬──────┬──────┬──────╮        ╭──────┬──────┬──────┬──────┬──────┬──────╮
│      │  !   │  @   │  #   │  $   │  %   │        │  ^   │  &   │  *   │  (   │  )   │      │
├──────┼──────┼──────┼──────┼──────┼──────┤        ├──────┼──────┼──────┼──────┼──────┼──────┤
│      │  ▽   │  ▽   │  ▽   │  ▽   │  ▽   │        │  -   │  =   │  [   │  ]   │  '   │      │
├──────┼──────┼──────┼──────┼──────┼──────┤        ├──────┼──────┼──────┼──────┼──────┼──────┤
│      │  ▽   │  ▽   │  ▽   │  ▽   │  ▽   │        │  _   │  +   │  ▽   │  ▽   │ NUBS │      │
╰──────┴──────┴──────┴──────┴──────┴──────╯        ╰──────┴──────┴──────┴──────┴──────┴──────╯
```

(BT keys and macro_ver moved to UTIL; the A-G / left-hand slots are
transparent and free for future symbols.)

## FUN

F1-F12 on the left hand. Currently UNREACHABLE: no layer activator points at
FUN (its own `&mo 3` is dead code). Wire a trigger before relying on it.

## MOUSE (hold left thumb 38; auto-activates on trackball movement)

```
╭──────┬──────┬──────┬──────┬──────┬──────╮        ╭──────┬──────┬──────┬──────┬──────┬──────╮
│      │  1   │  2   │  3   │  4   │  5   │        │  6   │  7   │  8   │  9   │  0   │      │
├──────┼──────┼──────┼──────┼──────┼──────┤        ├──────┼──────┼──────┼──────┼──────┼──────┤
│      │ LEFT │ DOWN │  UP  │RIGHT │      │        │ PGUP │ LCLK │ MCLK │ RCLK │      │      │
├──────┼──────┼──────┼──────┼──────┼──────┤        ├──────┼──────┼──────┼──────┼──────┼──────┤
│      │      │      │      │      │      │        │ PGDN │      │      │      │      │      │
╰──────┴──────┴──────┴──────┴──────┴──────╯        ╰──────┴──────┴──────┴──────┴──────┴──────╯
```

Clicks under the right home row: J/K/L = left/middle/right. Auto-mouse:
deliberate ball movement (threshold 20) activates this layer for 700ms.

## SCROLL (hold left-thumb Escape)

All transparent; the layer's only job is telling the PMW3610 driver to turn
ball motion into scrolling.

## SNIPE (hold left thumb 37)

All transparent; ball CPI drops 1200 -> 400 for precision aiming while held.

## UTIL (hold right-thumb Delete, by the trackball)

```
Left home row:  BT_CLR │ BT 0 │ BT 1 │ BT 2 │ macro_ver
```

Everything else deliberately dead (&none) so no stray keystrokes while
managing Bluetooth. `macro_ver` types the firmware build stamp
(`YYYYMMDD-<branch>-<commit>-kb44`; an `x` after the commit hash means the
build came from a dirty tree). BT_CLR forgets the pairing of the ACTIVE
profile - it sits next to the profile-select keys, mind the reach.

## Known gaps / ideas

- FUN layer unreachable (see above).
- Left Ctrl has no dedicated key (D/K holds only); CAPS took its spot.
- SYM left hand is empty real estate.
- NUM right hand (beyond digits) is empty real estate.
- caps_word is configured (`continue-list` includes `_` and `-`) but bound
  to no key.
