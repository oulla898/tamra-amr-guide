# Dual Network Setup: Tablet (RK3566) - Ethernet + WiFi Simultaneously

## Problem
The Android tablet (RK3566, Android 11) needs to connect to:
- **Robot chassis** via Ethernet (192.168.20.x) for local control
- **Internet** via WiFi for cloud services, updates, etc.

Android's ConnectivityService normally picks ONE default network. Ethernet (score 70) beats WiFi (score 60), causing internet loss when Ethernet is plugged in.

## Solution Implemented

### What We Did
1. **ADB root access** - userdebug build allows `adb root`
2. **Overlayfs** - `adb remount` enables writing to /system via overlay on /data
3. **Boot daemon script** at `/data/local/tmp/dual_network.sh`:
   - Sets eth0 static IP (192.168.20.100/24) via `ip addr add`
   - Adds routing rules: robot subnet -> eth0, everything else -> wlan0
   - Monitors and re-applies every 30 seconds (ConnectivityService may remove rules)
4. **Init service** at `/system/etc/init/dual_network.rc` (via overlayfs):
   - Starts the script at boot as a background daemon
5. **Private DNS** set to `dns.google` (DNS-over-TLS):
   - Persists in Android settings database
   - `settings put global private_dns_mode hostname`
   - `settings put global private_dns_specifier dns.google`
6. **Removed Speedify** - its VPN (tun0) was hijacking routing and DNS

### Routing Rules (applied by script)
```
Priority 9000: to 192.168.20.0/24 -> lookup eth0    (robot traffic)
```
No rule 9500. A catch-all wlan0 fallback would let Ethernet's connectivity check
succeed, validating Ethernet (score 70) and making it the default network. Without
DNS on eth0, apps lose internet. Removing rule 9500 keeps Ethernet unvalidated
(score 30) and WiFi as the default network for DNS and internet.

### Key Files
| File | Location | Purpose |
|------|----------|---------|
| Boot script | `/data/local/tmp/dual_network.sh` | Sets IP, routing rules, monitors |
| Init service | `/system/etc/init/dual_network.rc` | Starts script at boot |
| Ethernet config | `/data/misc/ethernet/ipconfig.txt` | Static IP config (format issues, script handles IP instead) |

### Test Results (all passing)
| Test | Latency |
|------|---------|
| Robot subnet (192.168.20.100) | 0.2ms |
| WiFi gateway (192.168.100.1) | 2ms |
| Internet (8.8.8.8) | 7ms |
| DNS (google.com) | 7ms |

## Tablet Specs
- **Model**: rk3566_r (Rockchip RK3566)
- **OS**: Android 11 (SDK 30), userdebug build
- **Kernel**: 4.19.232
- **Display**: 10.1" IPS 1280x800, capacitive 10-point touch
- **RAM/Storage**: 2GB / 16GB
- **Ports**: RJ45 (via 4P-2.0mm adapter), 2x USB Host, USB OTG, HDMI OUT, TF slot
- **Network**: WiFi 802.11 b/g/n, Bluetooth 4.0
- **Power**: 12V/2A adapter

## Troubleshooting

### If internet stops working after reboot:
```bash
adb root
adb shell "ip rule show | grep 9000"  # Check if rules exist
adb shell "logcat -s DualNet"          # Check script logs
adb shell "getprop init.svc.dual_network"  # Should be "running"
```

### Manual fix if script fails:
```bash
adb root
adb shell "ip addr add 192.168.20.100/24 dev eth0"
adb shell "ip rule add to 192.168.20.0/24 table eth0 priority 9000"
# Do NOT add a rule 9500 (see Routing Rules note above)
```

### If overlayfs is lost (factory reset):
```bash
adb root
adb remount          # Sets up overlayfs, requires reboot
adb reboot
# After reboot:
adb root
adb remount          # Now writable
# Re-create /system/etc/init/dual_network.rc
```

## Important Notes
- Do NOT install Speedify or any VPN that creates tun0 - it conflicts with routing
- The `ipconfig.txt` format is not reliably parsed by this Rockchip firmware; the script handles IP assignment instead
- SELinux is in permissive mode on this userdebug build (logged but not enforced)
- The script runs as `u:r:shell:s0` SELinux context


see
C:\Users\oulla\Desktop\SQU\competetions\sumo robot\fyp\tamra-amr-project\hardware\display\tablet-network or tamra if other machine