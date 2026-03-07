# matugen

[Matugen](https://github.com/InioX/matugen) generates Material You color schemes from a wallpaper image and writes them to configured output files.

## Dependencies

- `matugen` (AUR: `matugen-bin`)
- `python3` (stdlib — used by `sync-colors.sh` post-processing)

## How it works

1. Run matugen with a wallpaper: `matugen image /path/to/wallpaper.png`
2. Matugen reads `matugen.toml`, processes each `[templates.*]` entry, and writes output files.
3. DMS fires `onMatugenCompleted`, which runs `DankMaterialShell/scripts/sync-colors.sh` for post-processing (GTK fix, wava color, Papirus folder color).

In practice, DMS handles step 1 and 2 automatically when you change wallpapers.

## Templates

The `templates/` directory contains the source templates. **Edit templates here**, not the generated output files:

| Template | Output |
|----------|--------|
| `helix.toml` | `~/.config/helix/themes/matugen.toml` |
| `wava.ini` | `~/.config/wava/config` |
| `rmpc.ron` | `~/.config/rmpc/themes/matugen.ron` |
| `tmux-colors.conf` | `~/.tmux.conf` |
| `Matugen.colors` | `~/.config/matugen/templates/example/Matugen.colors` |

The yazi template lives at `/usr/share/quickshell/dms/matugen/templates/yazi-theme.toml` (system-managed by DMS).

## Paths

`matugen.toml` uses `~/` for all paths. Matugen supports `~/` expansion but not arbitrary environment variables like `$XDG_CONFIG_HOME`.
