# Tablet & Network

## On-board tablet — dual network

The tablet needs both `eth0` (chassis, 192.168.20.x) and `wlan0` (room Wi-Fi for internet) up at the same time. Android picks one by default — Ethernet wins, internet dies.

Fix: a boot daemon ([`assets/tablet-network/dual_network.sh`](assets/tablet-network/dual_network.sh)) sets `eth0` static and adds a routing rule so robot traffic goes over Ethernet and everything else goes over Wi-Fi. It re-applies every 30 s.

Setup writeups: [`assets/tablet-network/DUAL_NETWORK_SETUP.md`](assets/tablet-network/DUAL_NETWORK_SETUP.md), [`assets/tablet-network/DEPLOY.md`](assets/tablet-network/DEPLOY.md).

Don't install Speedify or any VPN on the tablet — `tun0` hijacks the routing.

## ADB cheat sheet

From [`assets/software/TABLET_HANDOFF.md`](assets/software/TABLET_HANDOFF.md):

```powershell
$ADB = "C:/Users/oulla/AppData/Local/Android/Sdk/platform-tools/adb.exe"
& $ADB devices
& $ADB root

& $ADB shell "getprop init.svc.dual_network"     # running
& $ADB shell "ip addr show eth0 | grep 'inet '"   # 192.168.20.100
& $ADB shell "ip rule show | grep 9000"           # rule 9000 present
& $ADB shell "ping -c 1 192.168.20.22"            # robot reachable
```

Push a new `robot-ui.html`:

```powershell
& $ADB push robot-ui.html /sdcard/robot-ui.html
& $ADB shell "am start -a android.intent.action.VIEW -d 'file:///sdcard/robot-ui.html'"
```

CRLF: after pushing any `.sh`, strip `\r` (`tr -d '\r'`) or it crashes silently.

## Your laptop ↔ robot

**Wi-Fi:** join `TY1251D-xxxxx` / `123456789`. Robot at `10.42.0.1`.

**Ethernet:** plug into the chassis's spare RJ45. No DHCP — set a static IP:

```powershell
New-NetIPAddress -InterfaceAlias "Ethernet 3" `
  -IPAddress 192.168.20.100 -PrefixLength 24 `
  -DefaultGateway 192.168.20.1
```

Robot at `192.168.20.22`. Verify: `Test-NetConnection 192.168.20.22 -Port 9090`.

## Endpoints

| | Wired | Wi-Fi |
|---|---|---|
| rosbridge | `ws://192.168.20.22:9090/` | `ws://10.42.0.1:9090/` |
| Camera streams (MJPEG index) | `http://192.168.20.22:9099/` | `http://10.42.0.1:9099/` |
