# Tablet Handoff — For Agents Working on the HTML App

## ADB Access
```bash
ADB="C:/Users/oulla/AppData/Local/Android/Sdk/platform-tools/adb.exe"
$ADB devices              # Verify tablet connected via USB
$ADB root                 # Get root (userdebug build, always works)
```

## Screen Mirror (interactive)
```bash
tablet                    # Opens live mirror, mouse = touch, keyboard works
```

## The Tablet
- **Model**: Rockchip RK3566, Android 11 (SDK 30), userdebug build
- **Display**: 10.1" IPS 1280x800, capacitive touch
- **RAM**: 2GB — keep memory usage low
- **Kiosk app**: Fully Kiosk Browser (`de.ozerov.fully`) — runs the HTML app fullscreen
- **App location**: HTML files are loaded by Fully Kiosk from a URL or local file

## Networking (dual network — DO NOT TOUCH)
The tablet has **two networks simultaneously**:

| Interface | Network | Purpose | IP |
|-----------|---------|---------|-----|
| `eth0` | Robot chassis (Ethernet) | rosbridge WebSocket | 192.168.20.100 |
| `wlan0` | eduroam (WiFi) | Internet, MQTT, APIs | DHCP (172.31.x.x) |

A boot daemon (`/data/local/tmp/dual_network.sh`) manages this. **Do NOT modify** the routing rules, IP addresses, or network config. If networking breaks, see `DEPLOY.md` for the fix procedure.

### Key connection details
- **Robot WebSocket**: `ws://192.168.20.22:9090` (rosbridge, JSON protocol)
- **Robot camera HTTP**: `http://192.168.20.22:9099/` (MJPEG, all image topics)
- **MQTT broker**: HiveMQ Cloud (URL, username, and password REDACTED — see private secrets vault).
  - **WARNING**: MQTT connect takes 10–90s on eduroam due to DPI. Connect eagerly on app load.

## Pushing Files to Tablet
```bash
# Push an HTML file:
$ADB push my_app.html //sdcard/my_app.html

# Open in browser (for testing):
$ADB shell "am start -a android.intent.action.VIEW -d 'file:///sdcard/my_app.html'"

# Open a URL in Fully Kiosk:
$ADB shell "am start -a android.intent.action.VIEW -d 'http://example.com' de.ozerov.fully"
```

## Useful ADB Commands
```bash
# Check all networking is healthy:
$ADB shell "getprop init.svc.dual_network"        # Should be: running
$ADB shell "ip addr show eth0 | grep 'inet '"      # Should be: 192.168.20.100
$ADB shell "ip rule show | grep 9000"              # Should show rule 9000
$ADB shell "ping -c 1 192.168.20.22"               # Robot reachable?

# Logs:
$ADB shell "logcat -d -s DualNet"                  # Dual network script logs
$ADB shell "logcat -d -s chromium"                  # Browser/WebView logs

# Screen control:
$ADB shell "input tap 640 400"                      # Tap center of screen
$ADB shell "input keyevent 4"                       # Back button
$ADB shell "input keyevent 3"                       # Home button
$ADB shell "screencap -p //sdcard/screen.png"       # Screenshot
$ADB pull //sdcard/screen.png                       # Pull to PC

# App management:
$ADB shell "pm list packages | grep fully"          # Kiosk browser package
$ADB shell "am force-stop de.ozerov.fully"          # Kill kiosk app
```

## The Main App
The tablet app is at `software/remote-drive/robot-ui.html` (4800+ lines, single-file HTML). It runs in Fully Kiosk Browser. It handles:
- MACS face (SVG animated eyes/mouth)
- Voice AI (ElevenLabs conversational)
- Orchestrator (Gemini LLM → mission plans)
- rosbridge WebSocket (robot control)
- MQTT bridge (relays robot data to cloud)
- Dashboard (map, waypoints, settings)

## CRITICAL: CRLF Warning
**Always strip `\r` after pushing shell scripts from Windows.** Git checks out `.sh` files with CRLF on Windows. Android's `/system/bin/sh` chokes on `\r` and the script will crash-loop silently.
```bash
$ADB shell "tr -d '\r' < /path/to/script.sh > /tmp/fix.sh && mv /tmp/fix.sh /path/to/script.sh"
```
`.gitattributes` has `*.sh text eol=lf` to prevent this, but verify after any push.
