# Talking to the Robot

The chassis runs ROS 1 with **rosbridge_server** over WebSocket. JSON in, JSON out — any language with a WS lib works. No ROS install needed.

Full topic/service writeup: [`assets/notes/reverse-engineering.md`](assets/notes/reverse-engineering.md).
Vendor protocol (the actual API spec, Chinese): [`assets/manuals/upper_computer_protocol_original.pdf`](assets/manuals/upper_computer_protocol_original.pdf). The `_translated.pdf` file with a similar name is actually the chassis hardware manual, not the protocol.
How we figured it out: [`assets/notes/protocol-analysis-log.md`](assets/notes/protocol-analysis-log.md).

## Endpoints

| | URL |
|---|---|
| rosbridge | `ws://192.168.20.22:9090/` (wired) · `ws://10.42.0.1:9090/` (Wi-Fi) |
| Camera streams (browser) | `http://192.168.20.22:9099/` |

Open the camera URL in any browser to confirm the robot is alive.

## Topics worth knowing

| Topic | Type | |
|---|---|---|
| `/robot_pose` | `geometry_msgs/Pose2D` | (x, y, θ) in map frame |
| `/scan` | `sensor_msgs/LaserScan` | LiDAR |
| `/map` | `nav_msgs/OccupancyGrid` | PNG-compressed map |
| `/robot_status` | custom | Battery, state, errors |
| `/upcamera/rgb/image_raw/compressed` | `sensor_msgs/CompressedImage` | Upward RGB JPEG |
| `/cmd_vel_mux/input/teleop` | `geometry_msgs/Twist` | **Publish to drive** |

## Services worth knowing

| Service | |
|---|---|
| `/set_init_pose` | Set localization |
| `/navi_goal` | Send nav goal |
| `/append_virtual_walls`, `/set_virtual_walls` | Forbidden zones |
| `/rosapi/topics`, `/rosapi/services`, `/rosapi/nodes` | Introspect everything else |

## Minimal Python

```python
import json, websocket

ws = websocket.create_connection("ws://192.168.20.22:9090/", timeout=5)

# Subscribe to pose
ws.send(json.dumps({
    "op": "subscribe", "id": "pose",
    "topic": "/robot_pose", "type": "geometry_msgs/Pose2D",
}))

# Drive forward at 0.2 m/s
ws.send(json.dumps({
    "op": "publish",
    "topic": "/cmd_vel_mux/input/teleop",
    "msg": {"linear": {"x": 0.2, "y": 0, "z": 0},
            "angular": {"x": 0, "y": 0, "z": 0}},
}))
```

## Watchdog

Always send zero velocity when your client closes, or send commands at a fixed rate and let the consumer time out to zero (our MQTT bridge uses 0.5 s).
