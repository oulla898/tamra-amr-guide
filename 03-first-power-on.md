# First Power-On

Full visual: [walkthrough video](08-videos.md#walkthrough) — 13 min, covers all of this end-to-end.

## Turn it on

Press the **ON button on the chassis at LiDAR level** (it's hidden — feel for it). Wait ~30 s for the tablet to come up.

Do **not** touch the main power switch under the chassis. It stays on.

## After boot

- Robot Wi-Fi: `TY1251D-xxxxx` / `123456789`, robot at `10.42.0.1`
- Tablet: should show the face (Fully Kiosk auto-loads `robot-ui.html`)
- Tablet has both `eth0` (192.168.20.x to chassis) and `wlan0` (room Wi-Fi) up — see [Tablet & Network](05-tablet-and-network.md) if not

## Set initial pose

After every power-on, tell the robot where it is on the map. Tap its location → drag to its facing direction → confirm.

## Turn it off

Press the ON button again (or use the soft-off in the app). Wait for it to power down.

To move it without power: hit the **kill switch** first (red mushroom, back of body), then push.

## Quick troubleshooting

| Symptom | Try |
|---|---|
| Nothing happens | Kill switch is engaged — twist to release |
| Tablet stays black | Tablet 12 V cable loose; open rear tray, reseat |
| Face never appears | Open Fully Kiosk manually |
| No robot Wi-Fi | Use Ethernet — see [Tablet & Network](05-tablet-and-network.md) |
