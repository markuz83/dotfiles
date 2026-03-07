# mpDris2

[mpDris2](https://github.com/eonpatapon/mpDris2) bridges MPD to the MPRIS2 D-Bus interface, allowing media players and desktop environments to control MPD via standard media keys, notifications, and taskbar integrations.

## Dependencies

- `mpDris2` (AUR: `mpdris2`)
- `mpd` (must be running)

## Setup

Enable and start via systemd (defined in the `systemd` package):

```sh
systemctl --user enable --now mpDris2.service
```

## Socket connection

`host = ~/.mpd/socket` connects to MPD over a Unix socket instead of TCP. This must match `bind_to_address` in `mpd.conf` and `MPD_HOST` in `fish/config.fish`. All three need to agree on the same socket path.

## Notes

- mpDris2 is bound to `mpd.service` — it starts and stops with MPD automatically.
- `--no-reconnect` flag in the systemd unit means it won't loop-retry if MPD is unavailable; systemd handles restarts instead.
- `music_dir` must be set for album art to work in MPRIS clients.
