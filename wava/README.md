# wava

[Wava](https://github.com/nicowillis/wava) audio visualizer configuration.

## Dependencies

- `wava`
- `mpd` with FIFO output configured (see `mpd/README.md`)
- `pipewire`

## How it integrates

1. MPD writes raw audio to `/tmp/mpd.fifo` (configured in `mpd.conf`)
2. Wava reads from that FIFO and renders the visualizer
3. On each DMS color change, `DankMaterialShell/scripts/sync-colors.sh`:
   - Reads the matugen foreground color from `~/.config/wava/config`
   - Darkens it by ~85% (so bars are visible against the background)
   - Writes the darkened color back into `config`
   - Kills and relaunches wava to pick up the new color

## Directories

- `cairo/` — Cairo renderer configuration
- `gl/` — OpenGL renderer configuration and shaders

## Notes

- `config` is the main wava config. The `foreground` value is overwritten by `sync-colors.sh` on every color change — don't set it to something you want to keep permanently.
- Wava is managed by `sync-colors.sh`, not a systemd unit. It runs as a background process launched with `nohup` and `disown`.
