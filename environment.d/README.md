# environment.d

Systemd user environment variables, loaded at login for the entire user session.

## Files

- `80-editor.conf` — sets `EDITOR` and `VISUAL` to `nvim`
- `90-dms.conf` — sets `ELECTRON_OZONE_PLATFORM_HINT=auto` and `TERMINAL=kitty`

## How it works

Files in `~/.config/environment.d/` are read by systemd and exported to the user session environment. They are **not** shell scripts — only `KEY=value` pairs, one per line. Changes require re-login to take effect.

Files are loaded in lexicographic order — hence the numeric prefixes.
