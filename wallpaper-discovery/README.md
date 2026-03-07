# wallpaper-discovery

Personal wallpapers worth keeping in version control.

## Stow target

This package uses a **different stow target** from the rest of the dotfiles. On a new machine, stow it manually:

```sh
cd ~/dotfiles
stow --target="$HOME/Pictures" wallpaper-discovery
```

The default `.stowrc` target (`~/.config`) does not apply here.

## Contents

- `cachyos_comet_trails.svg` — original Inkscape source (3840×2160, CachyOS cyan/teal palette, comet trail design)
- `cachyos_comet_trails-v3.png` — exported PNG render
