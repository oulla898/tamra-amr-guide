# Quick Start

End state: a saved map and a few waypoints the robot can drive to.

## You need

- The robot, charged.
- An Android phone or tablet.
- ~10 m² of clear floor.

## 1. Power on

Press the ** ON button at LiDAR level on the chassis**. Wait ~30 s.

Full sequence: [First Power-On](03-first-power-on.md).

> ### ▶ [Watch the 13-minute walkthrough first](08-videos.md)
> Seriously — every button, cable, and tablet screen is in that video. Most questions disappear after watching it.

## 2. Install the vendor app

[`assets/apk/DeploymentTool.apk`](assets/apk/DeploymentTool.apk) — install it on your phone/tablet.

A separate device is easier than the on-board tablet your first time: you can stand back.

## 3. Connect

Join the robot's Wi-Fi:

| SSID | `TY1251D-xxxxx` |
| Password | `123456789` |
| Robot IP | `10.42.0.1` |

Open the app. It auto-discovers the robot.

## 4. Drive it manually

Use the joystick. Get a feel for it. Know where the kill switch is (back of body, red mushroom).

## 5. Build a map

Start mapping → drive slowly, walking pace → cover every area → close loops by passing landmarks from different angles → save with a name.

If the map looks bad, restart. Don't try to repair it.

## 6. Drop waypoints

Drive to a spot → "add point" → name it (`lobby`, `cafe`, `room_203`) → save.

## 7. Set initial pose, then send it

After every power-on the robot doesn't know where it is. Tap its current spot on the map, drag to its facing direction, confirm.

Pick a waypoint → "go to". It plans, drives, avoids obstacles.

---

Next: [Our Software](06-our-software.md) for the tablet face + remote dashboard, or [Talking to the Robot](07-talking-to-the-robot.md) for the underlying rosbridge API.
