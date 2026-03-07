#!/usr/bin/env bash
# Runs on DankHooks onMatugenCompleted.
# Matugen has already regenerated all color files at this point — this script
# applies the downstream changes: GTK fix, wava restart, Papirus folder color.

set -euo pipefail

WAVA_CONFIG="$HOME/.config/wava/config"

# Kill any running wava instance
pkill wava || true

# Re-append GTK fix: matugen overwrites dank-colors.css from the system template,
# which lacks the backdrop selected text contrast fix for Thunar icon labels.
# Guard against duplication on repeated runs.
for _css in "$HOME/.config/gtk-3.0/dank-colors.css" "$HOME/.config/gtk-4.0/dank-colors.css"; do
  [[ -f "$_css" ]] && grep -qF 'icon label text contrast' "$_css" && continue
  [[ -f "$_css" ]] && cat >>"$_css" <<'EOF'

/* Fix: icon label text contrast for selected items (active and inactive windows) */
iconview:selected,
.view:selected,
iconview:backdrop:selected,
.view:backdrop:selected {
    color: @accent_fg_color;
}
EOF
done

# Read the foreground color matugen wrote into the wava config for Papirus matching
foreground=$(grep '^foreground = ' "$WAVA_CONFIG" | sed "s/foreground = '\\(.*\\)'/\\1/")

if [[ -z "$foreground" ]]; then
  echo "Error: Could not extract foreground from $WAVA_CONFIG" >&2
  exit 1
fi

echo "Foreground: $foreground"

# Darken the foreground so wava bars stand out from the background
DARK_FOREGROUND=$(
  python3 <<PYEOF
import colorsys

def hex_to_rgb(h):
    h = h.lstrip('#')
    return tuple(int(h[i:i+2], 16) / 255.0 for i in (0, 2, 4))

def rgb_to_hex(r, g, b):
    return '{:02x}{:02x}{:02x}'.format(int(r*255), int(g*255), int(b*255))

r, g, b = hex_to_rgb("$foreground")
h, l, s = colorsys.rgb_to_hls(r, g, b)
l = max(0.0, l * 0.15)  # reduce lightness ~85%
r2, g2, b2 = colorsys.hls_to_rgb(h, l, s)
print('#' + rgb_to_hex(r2, g2, b2))
PYEOF
)

echo "Wava color (darkened): $DARK_FOREGROUND"
sed -i "s/^foreground = '.*'/foreground = '$DARK_FOREGROUND'/" "$WAVA_CONFIG"

# Relaunch wava in the background (picks up the darkened foreground)
nohup /usr/bin/wava &>/dev/null &
disown
echo "Relaunched wava."

# --- Papirus-Dark folder color ---
BEST_COLOR=$(
  python3 <<PYEOF
import colorsys

PAPIRUS_COLORS = {
    "adwaita":    "#3584e4",
    "black":      "#1c1c1c",
    "blue":       "#1976d2",
    "bluegrey":   "#607d8b",
    "breeze":     "#3daee9",
    "brown":      "#795548",
    "carmine":    "#960018",
    "cyan":       "#00bcd4",
    "darkcyan":   "#008b8b",
    "deeporange": "#ff5722",
    "green":      "#4caf50",
    "grey":       "#9e9e9e",
    "indigo":     "#3f51b5",
    "magenta":    "#c2185b",
    "nordic":     "#5e81ac",
    "orange":     "#ff9800",
    "palebrown":  "#bcaaa4",
    "paleorange": "#ffcc80",
    "pink":       "#e91e63",
    "red":        "#f44336",
    "teal":       "#009688",
    "violet":     "#7b1fa2",
    "white":      "#f5f5f5",
    "yaru":       "#e95420",
    "yellow":     "#fdd835",
}

def hex_to_hls(h):
    h = h.lstrip('#')
    r, g, b = (int(h[i:i+2], 16) / 255.0 for i in (0, 2, 4))
    return colorsys.rgb_to_hls(r, g, b)  # (H 0-1, L 0-1, S 0-1)

def hue_dist(h1, h2):
    d = abs(h1 - h2)
    return min(d, 1.0 - d)  # circular distance on 0..1 wheel

tH, tL, tS = hex_to_hls("$foreground")

if tS < 0.10:  # near-neutral — pick by lightness
    if   tL < 0.25: print("black")
    elif tL > 0.75: print("white")
    else:           print("grey")
else:
    def score(name):
        pH, pL, pS = hex_to_hls(PAPIRUS_COLORS[name])
        if pS < 0.10:  # skip neutrals when target is saturated
            return 999.0
        return hue_dist(tH, pH)
    print(min(PAPIRUS_COLORS, key=score))
PYEOF
)

echo "Papirus color match: $BEST_COLOR"
papirus-folders -t Papirus-Dark -C "$BEST_COLOR"
echo "Papirus-Dark folders set to $BEST_COLOR."

# Restart any running file manager so it picks up the new icon color immediately
for fm in thunar pcmanfm; do
  if pgrep -x "$fm" >/dev/null; then
    echo "Restarting $fm to refresh folder icons..."
    open_windows=$(hyprctl clients -j 2>/dev/null |
      jq --arg c "$fm" '[.[] | select(.class | ascii_downcase == $c)] | length' 2>/dev/null ||
      echo 0)
    pkill -x "$fm" || true
    sleep 0.3
    if [[ "$open_windows" -gt 0 ]]; then
      "$fm" &
    else
      "$fm" --daemon &
    fi
    disown
    echo "Restarted $fm (${open_windows} window(s) were open)."
    break
  fi
done
