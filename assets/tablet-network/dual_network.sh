#!/system/bin/sh
# Dual Network: Ethernet (robot 192.168.20.x) + WiFi (internet)
# Runs at boot. Sets eth0 IP, adds routing rules, monitors and re-applies.
# Location on tablet: /data/local/tmp/dual_network.sh

log -t DualNet "Starting dual network setup..."

# Wait for eth0 link to come up
MAX_WAIT=60
WAITED=0
while [ $WAITED -lt $MAX_WAIT ]; do
    ETH_LINK=$(cat /sys/class/net/eth0/carrier 2>/dev/null)
    if [ "$ETH_LINK" = "1" ]; then
        break
    fi
    sleep 3
    WAITED=$((WAITED + 3))
done

if [ "$ETH_LINK" != "1" ]; then
    log -t DualNet "eth0 link not detected after ${MAX_WAIT}s. Will still configure IP."
fi

# Configure eth0 static IP if not already set
ETH_IP=$(ip addr show eth0 | grep 'inet 192.168.20.100')
if [ -z "$ETH_IP" ]; then
    ip addr add 192.168.20.100/24 dev eth0 2>/dev/null
    log -t DualNet "Set eth0 IP to 192.168.20.100/24"
fi

# Wait for WiFi
WAITED=0
while [ $WAITED -lt 60 ]; do
    WLAN_IP=$(ip addr show wlan0 | grep 'inet ')
    if [ -n "$WLAN_IP" ]; then
        break
    fi
    sleep 3
    WAITED=$((WAITED + 3))
done

# Apply routing rules
# Rule 9000: robot subnet always via eth0.
# NO rule 9500: do NOT add a catch-all wlan0 fallback.
#   If we add "from all lookup wlan0", Ethernet-fwmarked connectivity checks
#   are intercepted and succeed, causing Ethernet (score 70) to validate and
#   take over as default network, leaving apps with no DNS (eth0 has none).
#   Without rule 9500, Ethernet-tagged traffic falls through to ConnectivityService
#   rule 13000 (fwmark → eth0 table), which has no default route → check fails →
#   Ethernet stays score 30, WiFi (score 60, VALIDATED) remains default network.
#   WiFi-tagged app traffic uses ConnectivityService rules (13000 → wlan0 table) normally.
apply_rules() {
    ip rule del to 192.168.20.0/24 table eth0 priority 9000 2>/dev/null
    ip rule del lookup wlan0 priority 9500 2>/dev/null
    ip rule del fwmark 0x0/0xffff lookup wlan0 priority 9500 2>/dev/null
    ip rule add to 192.168.20.0/24 table eth0 priority 9000 2>/dev/null
    log -t DualNet "Routing rules applied."
}

apply_rules

# Monitor loop: re-apply every 30s for 5 minutes, then every 2 min forever
COUNTER=0
while true; do
    sleep 30

    # Re-check eth0 IP
    ETH_IP=$(ip addr show eth0 | grep 'inet 192.168.20.100')
    if [ -z "$ETH_IP" ]; then
        ETH_LINK=$(cat /sys/class/net/eth0/carrier 2>/dev/null)
        if [ "$ETH_LINK" = "1" ]; then
            ip addr add 192.168.20.100/24 dev eth0 2>/dev/null
            log -t DualNet "Re-applied eth0 IP"
        fi
    fi

    # Re-check routing rules
    HAS_RULE=$(ip rule show | grep 'priority 9000')
    if [ -z "$HAS_RULE" ]; then
        apply_rules
    fi

    COUNTER=$((COUNTER + 1))
    if [ $COUNTER -ge 10 ]; then
        sleep 90
    fi
done
