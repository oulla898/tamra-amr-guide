# Meet the Robot

Dimensions drawing: [`assets/renders/engineering-drawing.png`](assets/renders/engineering-drawing.png). All renders: [`assets/renders/`](https://github.com/oulla898/tamra-amr-guide/tree/main/assets/renders).

## Specs

| | |
|---|---|
| Height | 900 mm |
| Base | 500 mm diameter |
| Weight | ~40 kg |
| Payload | 50 kg |
| Battery | 24 V / 20 Ah Li-ion |

## Stack

```
   Tablet (face + UI)        ← 10.1" Android, 40° tilt
   Wooden body               ← LED strip, kill switch, rear tray
   iMRP500 chassis           ← wheels, LiDAR, depth cameras, battery, ROS PC
```

### Chassis (iMRP500)

Differential drive, 2D LiDAR, two depth cameras (up + down), ultrasonics, 24 V battery, x86 ROS 1 PC. Two Ethernet ports — one to the tablet, one spare for your laptop.

Spec: [`assets/manuals/iMRP500_SPEC.pdf`](assets/manuals/iMRP500_SPEC.pdf). Datasheet: [`assets/manuals/iMRP500_datasheet.pdf`](assets/manuals/iMRP500_datasheet.pdf). Chassis user manual (machine-translated): [`assets/manuals/upper_computer_protocol_translated.pdf`](assets/manuals/upper_computer_protocol_translated.pdf).

### Body

Wooden subframe with acrylic front. 40° top tilt for the tablet. Rear tray lifts up for tablet access.

### Tablet

10.1" RK3566, Android 11. 12 V from the chassis, Ethernet to the chassis, Wi-Fi to the room. Runs Fully Kiosk Browser with our `robot-ui.html`.

## Buttons and things to know

| What | Where | What it does |
|---|---|---|
| **ON button** | Top of chassis, at LiDAR level | Turn the robot on |
| **Kill switch** | Back of body, red mushroom | Free-wheels the motors so you can push it |
| **Charge port** | Rear of chassis | 24 V charger |

The main power switch under the chassis is left alone. Use the ON button.
