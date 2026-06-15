# Tablet Network: Dual WiFi + Ethernet

Scripts deployed to the RK3566 Android 11 tablet to enable simultaneous WiFi (internet) and Ethernet (robot chassis at 192.168.20.x) connectivity.

**Source**: `fyp/robot opt/display opt/tablet-scripts-fix-net/`

- `dual_network.sh` - Boot daemon: configures eth0 static IP, applies routing rules, monitors
- `dual_network.rc` - Android init service definition (placed in /system/etc/init/)
- `ipconfig.txt` - Ethernet configuration template
- `DEPLOY.md` - Step-by-step ADB deployment instructions
- `DUAL_NETWORK_SETUP.md` - Full documentation of the problem and solution
