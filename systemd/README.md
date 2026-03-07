# systemd

Systemd user units for session management and services.

## Structure

```
user/
├── dms.service                         # DankMaterialShell service
├── dms.service.d/
│   ├── override.conf                   # Qt/Electron env vars; skips KDE sessions
│   └── session.conf                    # Scopes DMS to dms-session.target
├── dms-session.target                  # DMS session target
├── hyprland-session.target             # Started by hyprland.conf exec-once
├── hyprland-session.target.d/
│   └── dms-session.conf               # Pulls dms-session.target into Hyprland
├── niri-session.target                 # Started by niri.service
├── niri-session.target.d/
│   └── dms-session.conf               # Pulls dms-session.target into Niri
├── niri.service.d/
│   └── session-target.conf            # Wires niri.service → niri-session.target
├── mango-session.target                # Started by mango config exec-once
├── mpd.service                         # MPD override unit
├── mpDris2.service                     # mpDris2 user service
├── virtual-surround-sound.service      # Decky virtual surround sound plugin
├── gamescope-session.service.d/
│   └── override.conf                  # Unsets display env vars for gamescope
├── plasma-xdg-desktop-portal-kde.service.d/
│   └── no-plasma-core-ordering.conf   # Prevents portal deadlock without full Plasma
└── xdg-desktop-portal-hyprland.service.d/
    └── condition.conf                 # Only runs portal when XDG_CURRENT_DESKTOP=Hyprland
```

## After cloning on a new machine

Reload the unit files and enable services:

```sh
systemctl --user daemon-reload
systemctl --user enable mpd.service mpDris2.service
```

DMS, niri, and Hyprland session targets are started automatically by the compositor on launch — no manual enabling needed.

## Systemd path specifiers

Units use `%h` instead of `/home/username` for the home directory. This makes them portable across usernames.

## virtual-surround-sound.service

`ExecStart=%h/homebrew/plugins/decky-virtual-surround-sound/service.sh run` — the path to the Decky plugin is machine-specific. Update this if the plugin is installed elsewhere.

## The plasma portal fix

`plasma-xdg-desktop-portal-kde.service.d/no-plasma-core-ordering.conf` removes `After=plasma-core.target`. Without this, D-Bus activation of the KDE portal cascades into ~26 waiting jobs that deadlock the user systemd instance when running Hyprland/Niri without a full Plasma session.
