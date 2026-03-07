# xsettingsd

[xsettingsd](https://github.com/derat/xsettingsd) propagates GTK and font rendering settings to X11/XWayland applications via the XSETTINGS protocol.

## Why this exists

On GNOME and KDE, the desktop environment broadcasts XSETTINGS automatically. On Hyprland/Niri/MangoWC there's no DE to do this, so GTK apps running under XWayland fall back to system defaults — wrong icon theme, wrong font hinting, no cursor theme. xsettingsd fills that gap.

## Dependencies

- `xsettingsd`

## Setup

xsettingsd needs to be running when X11/XWayland apps launch. Start it as part of your session. The simplest approach on these dotfiles is to add it to your compositor's autostart, or enable it as a systemd user service if you create one.

Quick test:
```sh
xsettingsd &
```

## Settings

| Setting | Value |
|---------|-------|
| GTK theme | `adw-gtk3` |
| Icon theme | `Papirus-Dark` |
| Cursor theme | `Adwaita` |
| Font antialiasing | enabled |
| Font hinting | `hintmedium` |
| Subpixel rendering | `rgb` |

These should stay in sync with `gtk-3.0/settings.ini` and `qt6ct.conf`.
