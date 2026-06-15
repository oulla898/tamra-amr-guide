# Mapping & Waypoints

We use the vendor's **DeploymentTool** app for mapping and waypoints. Day-to-day driving uses [Our Software](06-our-software.md).

APK: [`assets/apk/DeploymentTool.apk`](assets/apk/DeploymentTool.apk). Install on a personal phone/tablet (easier than the on-board tablet your first time — you can stand back).

## Connect

Join `TY1251D-xxxxx` / `123456789`. Open the app — it finds the robot at `10.42.0.1`. If not, point it there manually.

## Build a map

1. Start the robot in a corner.
2. **Start mapping** in the app.
3. Drive slowly. Cover every area. Close loops.
4. Save with a name.

Things that wreck a map: fast turns, glass/mirrors, people walking through the scan. If it ends up bad, **restart** — don't repair.

## Place waypoints

Drive to a spot → **Add point** → name it (`lobby`, `cafe`, `room_203`) → save. You can also set heading and approach behaviour per point.

## Set initial pose

After every power-on: tap robot's current spot → drag to facing direction → confirm.

## Send it

Tap a waypoint → **Go to**. The robot plans, drives, avoids. If stuck, joystick it 30 cm away from the obstacle and retry.

## Virtual walls

Draw forbidden zones on the map for stairs, glass, off-limits rooms. Protocol detail in [`assets/manuals/upper_computer_protocol_original.pdf`](assets/manuals/upper_computer_protocol_original.pdf) (the API spec, in Chinese).

## Visual labels (advanced)

AprilTag markers for narrow-doorway / elevator localization fixes. See [`assets/notes/reverse-engineering.md`](assets/notes/reverse-engineering.md).
