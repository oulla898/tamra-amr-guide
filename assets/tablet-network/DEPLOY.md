# How to Deploy These Scripts to the Tablet

## Prerequisites
- USB cable connected between PC and tablet
- ADB installed at: C:\Users\oulla\AppData\Local\Android\Sdk\platform-tools\adb.exe

## Full Setup (from scratch)

Run these commands in PowerShell:

```powershell
$adb = "C:\Users\oulla\AppData\Local\Android\Sdk\platform-tools\adb.exe"
```

### 1. Get root and enable overlayfs

```powershell
& $adb root
& $adb remount
& $adb reboot
# Wait ~60 seconds for tablet to boot
& $adb root
& $adb remount
```

### 2. Push the boot script

```powershell
& $adb push dual_network.sh /data/local/tmp/dual_network.sh
& $adb shell "chmod 755 /data/local/tmp/dual_network.sh"
```

### 3. Push the init service (starts script at boot)

```powershell
& $adb push dual_network.rc /system/etc/init/dual_network.rc
& $adb shell "chmod 644 /system/etc/init/dual_network.rc"
```

### 4. Push the Ethernet config (optional, script handles IP anyway)

```powershell
& $adb push ipconfig.txt /data/misc/ethernet/ipconfig.txt
```

### 5. Set Private DNS (persists in Android settings DB)

```powershell
& $adb shell "settings put global private_dns_mode hostname"
& $adb shell "settings put global private_dns_specifier dns.google"
```

### 6. Disable captive portal detection

```powershell
& $adb shell "settings put global captive_portal_mode 0"
& $adb shell "settings put global captive_portal_detection_enabled 0"
```

### 7. Reboot to activate

```powershell
& $adb reboot
```

## Quick Re-deploy (if overlayfs already set up)

```powershell
$adb = "C:\Users\oulla\AppData\Local\Android\Sdk\platform-tools\adb.exe"
& $adb root
& $adb remount
& $adb push dual_network.sh /data/local/tmp/dual_network.sh
& $adb shell "chmod 755 /data/local/tmp/dual_network.sh"
& $adb push dual_network.rc /system/etc/init/dual_network.rc
& $adb shell "chmod 644 /system/etc/init/dual_network.rc"
& $adb reboot
```

## Manual Fix (if script isn't running)

```powershell
& $adb root
& $adb shell "ip addr add 192.168.20.100/24 dev eth0"
& $adb shell "ip rule add to 192.168.20.0/24 table eth0 priority 9000"
& $adb shell "ip rule add lookup wlan0 priority 9500"
```

## Verify Everything Works

```powershell
& $adb shell "getprop init.svc.dual_network"           # Should say: running
& $adb shell "ip rule show | grep 9000"                 # Should show rule
& $adb shell "ping -c 1 192.168.20.100"                 # Robot subnet
& $adb shell "ping -c 1 google.com"                     # Internet + DNS
& $adb shell "logcat -d -s DualNet"                      # Script logs
```

## File Locations on Tablet

| File | Path on Tablet |
|------|---------------|
| Boot script | /data/local/tmp/dual_network.sh |
| Init service | /system/etc/init/dual_network.rc (overlayfs) |
| Ethernet config | /data/misc/ethernet/ipconfig.txt |
| Private DNS | Android settings DB (survives reboots) |
