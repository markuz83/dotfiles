#!/bin/bash

# Comprehensive logout script supporting MangoWC, Hyprland, and Niri
# Handles proper cleanup and HDR state reset before session exit

if [ -n "$NIRI_SOCKET" ]; then
  # Niri window manager detected
  niri msg action quit --skip-confirmation
elif [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
  # Hyprland window manager detected

  # Check if DP-2 has HDR enabled before attempting reset
  # HDR can be indicated by: "hdr": true in hyprctl output, hdredid parameter, or hdr in monitor config
  monitors_json=$(hyprctl monitors -j)

  if echo "$monitors_json" | grep -q '"name":"DP-2"'; then
    dp2_config=$(echo "$monitors_json" | grep -A 30 '"name":"DP-2"')

    # Check for HDR indicators in hyprctl output ("hdr": true or hdredid parameter)
    if echo "$dp2_config" | grep -qE '("hdr":\s*true|"hdredid")'; then
      # Reset DP-2 from HDR back to wide color (no HDR) before logging out.
      # Runs while Hyprland is fully live so the DRM color state is committed before exit.
      hyprctl keyword monitor DP-2,3840x2160@165,0x0,1.0,vrr,1
      sleep 0.5
    fi
  else
    # DP-2 not found in monitors JSON, check if it's configured with hdr in output.conf
    # by looking at the actual monitor configuration
    if hyprctl keyword list 2>/dev/null | grep -q 'monitor.*DP-2.*hdr'; then
      hyprctl keyword monitor DP-2,3840x2160@165,0x0,1.0,vrr,1
      sleep 0.5
    fi
  fi
  hyprshutdown
  sleep 2
  #hyprctl dispatch exit
elif command -v mangowc &>/dev/null; then
  # MangoWC window manager detected

  # Optional: Reset DP-2 HDR state if needed (uncomment if using HDR on MangoWC)
  # hyprctl keyword monitor DP-2,3840x2160@165,0x0,1.25,vrr,1
  # sleep 0.5

  # MangoWC uses systemd user services, so stop the session target
  systemctl --user stop mango-session.target

  # Alternative: if mango-session.target doesn't fully exit, can also use:
  # killall mangowc
else
  # Fallback: attempt generic session exit
  # This handles generic Wayland or X11 sessions
  if command -v loginctl &>/dev/null; then
    loginctl terminate-session "$XDG_SESSION_ID"
  else
    # Last resort: kill the session
    kill "$PPID"
  fi
fi
