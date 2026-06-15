# iMRP500 Chassis - Connection Guide & Findings

## Network Connection

### Wired (Ethernet)

| Parameter | Value |
|---|---|
| Robot IP | `192.168.20.22` |
| Your PC IP | `192.168.20.100` |
| Subnet | `255.255.255.0` (`/24`) |
| Gateway | `192.168.20.1` |

PowerShell (run as admin):

```powershell
New-NetIPAddress -InterfaceAlias "Ethernet 3" -IPAddress 192.168.20.100 -PrefixLength 24 -DefaultGateway 192.168.20.1
```

### WiFi

| Parameter | Value |
|---|---|
| SSID | `TY1251D-xxxxx` |
| Password | `123456789` |
| Robot IP | `10.42.0.1` |

---

## Ports & Protocols

| Port | Service | URL |
|---|---|---|
| **9090** | rosbridge (WebSocket) | `ws://192.168.20.22:9090/` |
| **9099** | web_video_server (HTTP/MJPEG) | `http://192.168.20.22:9099/` |

The robot runs **ROS** with a **rosbridge_server** exposing topics and services over WebSocket using JSON. Communication uses the standard rosbridge protocol with ops: `subscribe`, `publish`, `call_service`, `advertise`.

---

## Camera System

The robot has an **RGBD depth camera** (Orbbec-type, structured light) mounted pointing **upward** to detect overhead obstacles.

### Camera Topics

| Topic | Type | Description |
|---|---|---|
| `/upcamera/rgb/image_raw` | `sensor_msgs/Image` | Raw RGB image |
| `/upcamera/rgb/image_raw/compressed` | `sensor_msgs/CompressedImage` | JPEG compressed RGB |
| `/upcamera/depth/image_raw` | `sensor_msgs/Image` | Raw depth (16UC1) |
| `/upcamera/depth/image_raw/compressed` | `sensor_msgs/CompressedImage` | Compressed depth |
| `/upcamera/ir/image` | `sensor_msgs/Image` | Infrared image |
| `/upcamera/ir/image/compressed` | `sensor_msgs/CompressedImage` | Compressed IR |
| `/upcamera/depth/points` | `sensor_msgs/PointCloud2` | 3D point cloud |
| `/upcam_data` | custom | Processed point cloud (px/py arrays) |

### Viewing the Camera

**Option 1 - Browser (live MJPEG stream):**

Open `http://192.168.20.22:9099/` to see available streams. Direct stream URLs:

```
http://192.168.20.22:9099/stream?topic=/upcamera/rgb/image_raw
http://192.168.20.22:9099/stream?topic=/upcamera/depth/image_raw
http://192.168.20.22:9099/stream?topic=/upcamera/ir/image
```

**Option 2 - WebSocket (grab single frame):**

```python
import json, base64, websocket

ws = websocket.create_connection("ws://192.168.20.22:9090/", timeout=5)
ws.send(json.dumps({
    "op": "subscribe",
    "id": "cam",
    "topic": "/upcamera/rgb/image_raw/compressed",
    "type": "sensor_msgs/CompressedImage",
    "throttle_rate": 1000,
}))

msg = json.loads(ws.recv())
img = base64.b64decode(msg["msg"]["data"])
with open("frame.jpg", "wb") as f:
    f.write(img)

ws.send(json.dumps({"op": "unsubscribe", "id": "cam", "topic": "/upcamera/rgb/image_raw/compressed"}))
ws.close()
```

### Camera Nodes (16 running)

```
/upcamera/driver
/upcamera/upcamera_nodelet_manager
/upcamera/depth_metric
/upcamera/depth_metric_rect
/upcamera/depth_rectify_depth
/upcamera/depth_points
/upcamera/depth_registered_sw_metric_rect
/upcamera/register_depth_rgb
/upcamera/rgb_rectify_color
/upcamera/points_xyzrgb_sw_registered
/upcamera_base_link, _base_link1, _base_link2, _base_link3
/pointcloud_process_camera_below_nodelet
/web_video_server_1
```

---

## Obstacle Avoidance Configuration

The costmap has **four layers** for obstacle detection:

### Costmap Plugins (local & global)

| Layer | Type | Source | Range | Max Height |
|---|---|---|---|---|
| `obstacle_layer` | `costmap_2d::ObstacleLayer` | lidar `/scan` | 4.0m | 0.6m |
| `up_camera_layer` | `costmap_2d::ObstacleLayer` | depth cam `/up_camera_scan` | 3.5m | 2.0m |
| `down_camera_layer` | `costmap_2d::ObstacleLayer` | depth cam `/down_camera_scan` | 3.5m | 2.0m |
| `inflation_layer` | `costmap_2d::InflationLayer` | -- | radius 0.8m | scaling 10.0 |
| `virtual_layer` | `yutong_assistance::VirtualLayer` | virtual walls | -- | -- |

### How Overhead Obstacle Detection Works

1. The upward depth camera generates a 3D point cloud (`/upcamera/depth/points`)
2. This is converted to a virtual 2D laser scan (`/up_camera_scan`)
3. The `up_camera_layer` in the costmap marks cells as occupied based on this scan
4. The planner routes around these marked cells

### Tuning Parameters (via rosapi/set_param)

```python
# Increase detection range (default 3.5m)
ws.send(json.dumps({
    "op": "call_service",
    "service": "/rosapi/set_param",
    "args": {"name": "/move_base/local_costmap/up_camera_layer/obstacle_range", "value": "5.0"}
}))

# Increase safety inflation radius (default 0.8m)
ws.send(json.dumps({
    "op": "call_service",
    "service": "/rosapi/set_param",
    "args": {"name": "/move_base/local_costmap/inflation_layer/inflation_radius", "value": "1.2"}
}))
```

### Current Move Base Settings

| Parameter | Value |
|---|---|
| Robot radius | 0.33m |
| Local costmap | 3x3m, resolution 0.03m, update 8Hz |
| Global costmap | 10x10m, resolution 0.05m, update 4Hz |
| Controller frequency | 10Hz |
| Planner frequency | 0.5Hz |
| Recovery behavior | enabled |

---

## Other Sensors & Topics

| Topic | Type | Description |
|---|---|---|
| `/scan` | `sensor_msgs/LaserScan` | 2D lidar |
| `/robot_pose` | `geometry_msgs/Pose2D` | Robot position (x, y, theta) |
| `/robot_status` | custom | Battery, state, errors |
| `/map` | `nav_msgs/OccupancyGrid` | Occupancy grid map (PNG compressed) |
| `/mobile_base/sensors/core` | custom | Kobuki base sensor data |
| `/localization_confidence` | custom | Localization quality score |
| `/obstacle_region` | custom | Detected obstacle regions |
| `/downcam_data` | custom | Downward camera point data |
| `/cmd_vel_mux/input/teleop` | `geometry_msgs/Twist` | Manual velocity control |

---

## Key Services

| Service | Description |
|---|---|
| `/navi_setting` | Navigation configuration |
| `/sensors_config` | Sensor enable/disable |
| `/sensor_setting/ultrasonic` | Ultrasonic sensor configuration |
| `/laser_detection/setting` | Laser obstacle detection toggle |
| `/laser_safety_controller/setting_confidence_threshold` | Safety threshold |
| `/node_manager/laser_safety_controller` | Laser safety node control |
| `/node_manager/laser_safety_range` | Safety range control |
| `/upcamera_extrinsic_autocalibrate` | Up camera calibration |
| `/downcamera_extrinsic_autocalibrate` | Down camera calibration |
| `/set_init_pose` | Set initial position |
| `/navi_goal` | Send navigation goal |
| `/append_virtual_walls` | Add virtual walls to map |
| `/set_virtual_walls` | Set virtual walls |
| `/rosapi/get_param` | Read ROS parameter |
| `/rosapi/set_param` | Write ROS parameter |
| `/rosapi/topics` | List all topics |
| `/rosapi/services` | List all services |
| `/rosapi/nodes` | List all nodes |

---

## Navigation Modes

| Mode | Service Path |
|---|---|
| Auto navigation | `navigation_mode/auto_navi` |
| Follow path | `navigation_mode/follow_path` |

---

## Visual Labels (vSLAM-like Feature)

The app calls this "Visual Label Calibration Mode". It uses the camera to create visual landmark points on the map for more accurate positioning. Managed through the `VisualLabelAdapter` in the deployment tool app. Relevant topics:

- `/apriltags_buffer` -- AprilTag fiducial marker detection
- Point types: `POINT_VISUAL_LABEL`

---

## Quick Start (Python)

Install dependency:

```bash
pip install websocket-client
```

Connect and subscribe to robot pose:

```python
import json, websocket

ws = websocket.create_connection("ws://192.168.20.22:9090/", timeout=5)

ws.send(json.dumps({
    "op": "subscribe",
    "id": "pose",
    "topic": "/robot_pose",
    "type": "geometry_msgs/Pose2D",
}))

while True:
    msg = json.loads(ws.recv())
    if msg.get("topic") == "/robot_pose":
        pose = msg["msg"]
        print(f"x={pose['x']:.2f}  y={pose['y']:.2f}  theta={pose['theta']:.2f}")
```

Send velocity command:

```python
ws.send(json.dumps({
    "op": "publish",
    "topic": "/cmd_vel_mux/input/teleop",
    "msg": {"linear": {"x": 0.2, "y": 0.0, "z": 0.0},
            "angular": {"x": 0.0, "y": 0.0, "z": 0.0}},
}))
```

---

## Files in This Repo

| File | Description |
|---|---|
| `robot_experiments/robot_ws_test.py` | Basic WebSocket connectivity test, pose + map subscription |
| `robot_experiments/robot_probe_topics.py` | Brute-force topic/service discovery |
| `robot_experiments/robot_camera_grab.py` | Grab camera frames (RGB, depth, IR) |
| `robot_experiments/robot_query_settings.py` | Query sensor config and navigation settings |
| `robot_experiments/robot_costmap_params.py` | Dump all costmap layer parameters |
| `robot_experiments/test_overhead_detection.py` | Diagnose if overhead obstacle avoidance works |
| `robot_experiments/drive.html` | Remote drive UI (open in any browser) |
| `robot_experiments/mqtt_bridge.py` | MQTT-to-robot bridge (runs on laptop) |
| `ChassisDemo/` | Android SDK demo project (Java) |
| `DeploymentTool_*.apk` | Vendor deployment/configuration app |

---

## Remote Driving (from anywhere via MQTT)

### Architecture

```
drive.html (any browser, any network)
    |
    | MQTT over WSS (port 8884)
    v
HiveMQ Cloud (internet broker)
    |
    | MQTT over TLS (port 8883)
    v
mqtt_bridge.py (laptop, on robot network)
    |
    | WebSocket (port 9090)
    v
Robot rosbridge -> /cmd_vel_mux/input/teleop
```

### Setup

1. Connect laptop to robot network (wired or WiFi)

2. Start the bridge on the laptop:

```bash
pip install paho-mqtt websocket-client
python robot_experiments/mqtt_bridge.py
```

3. Open `robot_experiments/drive.html` in any browser (phone, tablet, another PC -- works from anywhere with internet)

4. Drive with:
   - **Joystick** (touch or mouse drag)
   - **Keyboard**: W/A/S/D or arrow keys, Space = emergency stop
   - **Buttons**: Forward, Back, Left, Right, STOP
   - **Sliders**: adjust max speed and max turn rate

### Safety

- The bridge has a **watchdog timer** (0.5s). If no commands arrive, the robot automatically stops
- Pressing STOP sends zero velocity immediately
- Releasing the joystick sends zero velocity

---

## Reference Documents

- `上位机通信协议 Upper computer communication protocol` -- WebSocket JSON protocol specification
- `iMRP500底盘用户使用手册` -- Hardware user manual
