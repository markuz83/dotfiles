# fish

Fish shell configuration.

## Dependencies

- `fish`
- `fisher` (plugin manager — install separately: `curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher`)
- `fzf`, `zoxide`, `tide` (installed via fisher — see `fish_plugins`)
- `yazi` (for the `y` function)
- `broot` (for the `br` function — symlinked via broot's own install)

## After cloning

Restore fisher plugins:

```fish
fisher update
```

This reads `fish_plugins` and installs everything listed.

## Notes

- Sources `/usr/share/cachyos-fish-config/cachyos-config.fish` — CachyOS-specific. Remove or replace this line on non-CachyOS systems.
- `MPD_HOST=~/.mpd/socket` tells MPD clients (rmpc, mpc, etc.) to connect via socket instead of TCP. Must match `bind_to_address` in `mpd.conf`.
- The `y` function wraps yazi so that exiting yazi changes your shell's working directory to wherever you navigated.
- `fish_variables` and `fish_variablesmFAnP50CVE` are runtime state files and are intentionally not tracked.
