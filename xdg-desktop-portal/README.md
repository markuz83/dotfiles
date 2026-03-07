# xdg-desktop-portal

Portal backend configuration for Hyprland.

## Dependencies

- `xdg-desktop-portal-hyprland`
- `xdg-desktop-portal-gtk`

## Why both?

`xdg-desktop-portal-hyprland` handles Hyprland-specific portals (screen capture, global shortcuts), but doesn't implement everything. `hyprland-portals.conf` splits the responsibilities:

| Portal | Backend |
|--------|---------|
| Screenshot, ScreenCast, GlobalShortcuts | hyprland |
| Inhibit, AppChooser, FileChooser, Notification, Settings | gtk |

Without this file, the portal selection is ambiguous and can result in broken screen sharing, missing file dialogs, or notification failures.

## Notes

- This config is specific to Hyprland. Under Niri or MangoWC, portals are handled differently — this file has no effect unless `XDG_CURRENT_DESKTOP=Hyprland`.
- The `xdg-desktop-portal-hyprland.service.d/condition.conf` unit (in the `systemd` package) ensures the hyprland portal service only starts when running Hyprland.
