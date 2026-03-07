# DankMaterialShell scripts

Custom scripts for [DankMaterialShell (DMS)](https://github.com/Beastwick18/dms).

## Scripts

### `sync-colors.sh`

Triggered by the DMS `onMatugenCompleted` hook — runs automatically after matugen regenerates color files.

Does three things:
1. Re-appends the GTK backdrop fix to `gtk-3.0/dank-colors.css` and `gtk-4.0/dank-colors.css` (matugen overwrites these from system templates, which lack the fix for Thunar icon label contrast in inactive windows).
2. Darkens the matugen foreground color by ~85% and writes it into `~/.config/wava/config`, then relaunches wava.
3. Finds the closest Papirus-Dark folder color to the current foreground and applies it with `papirus-folders`.

Dependencies: `wava`, `papirus-folders`, `python3` (stdlib only), `jq`, `hyprctl`

### `logout.sh`

Handles session exit for Niri, Hyprland, and MangoWC from a single script. Also resets DP-2 from HDR to SDR before Hyprland exits to prevent the display getting stuck in an HDR state after logout.

## Hook setup

In DMS, point the `onMatugenCompleted` hook at `sync-colors.sh`. This is configured inside DMS itself, not here.
