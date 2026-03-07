# mpd

[Music Player Daemon](https://www.musicpd.org/) configuration.

## Dependencies

- `mpd`
- `pipewire` (audio output)

## First-time setup

MPD needs its state directory before it can start. Create it:

```sh
mkdir -p ~/.mpd/playlists
```

MPD will create the socket, pid file, log, and sticker database automatically on first run. The directory just needs to exist first.

Then enable the service (defined in the `systemd` package):

```sh
systemctl --user enable --now mpd.service
```

## Socket vs TCP

`bind_to_address "~/.mpd/socket"` makes MPD listen on a Unix socket instead of port 6600. This is more secure and slightly faster. Any MPD client needs to know to use the socket:

- **fish**: `MPD_HOST=~/.mpd/socket` in `config.fish`
- **mpDris2**: `host = ~/.mpd/socket` in `mpDris2.conf`
- **rmpc**: configured in `rmpc/config.ron`
- **command-line**: `export MPD_HOST=~/.mpd/socket` (or set in fish)

## FIFO output

The `fifo` audio output at `/tmp/mpd.fifo` feeds wava for audio visualization. Wava reads from this FIFO to generate the visualizer bars. This is separate from the PipeWire output — both can be active simultaneously.

## Music directory

`music_directory "~/Music/"` — mpd supports `~`, `$HOME`, `$XDG_MUSIC_DIR`, and other XDG variables natively.
