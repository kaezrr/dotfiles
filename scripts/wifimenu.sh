#!/usr/bin/env bash
#
# wifi-menu.sh
# A “dmenu/fzf” style Wi-Fi selector that:
#   • auto‐detects multiple wireless interfaces (asks if >1)
#   • shows signal‐strength icons in fuzzel mode
#   • skips password prompt for open networks
#   • reuses saved nmcli profiles (so it “caches” automatically)
#   • falls back to fzf if fuzzel isn’t installed
#

set -euo pipefail

#### 1) Determine which wireless interface to use ####

# Gather all devices of type “wifi”:
mapfile -t wifi_ifaces < <( nmcli -t -f DEVICE,TYPE dev status | awk -F: '$2=="wifi" {print $1}' )

if [ ${#wifi_ifaces[@]} -eq 0 ]; then
    notify-send "No Wi-Fi interfaces detected"
    echo "Error: No Wi-Fi interfaces found." >&2
    exit 1
elif [ ${#wifi_ifaces[@]} -gt 1 ]; then
    # More than one wireless interface → let the user choose
    # We’ll attempt fuzzel first; if not present, fall back to fzf.
    if command -v fuzzel &>/dev/null; then
        iface=$(printf "%s\n" "${wifi_ifaces[@]}" | \
            fuzzel --dmenu --prompt "Select interface:" )
    elif command -v fzf &>/dev/null; then
        iface=$(printf "%s\n" "${wifi_ifaces[@]}" | \
            fzf --prompt="Interface: " --height=10 )
    else
        echo "Error: Neither fuzzel nor fzf is installed, cannot pick interface." >&2
        notify-send "Need fuzzel or fzf to pick interface"
        exit 1
    fi

    [ -z "$iface" ] && exit 0   # If user pressed Esc or didn’t pick, quit.
else
    # Exactly one interface, just use it
    iface="${wifi_ifaces[0]}"
fi

#### 2) Scan for Wi-Fi networks (SSID, SECURITY, SIGNAL) ####

# We force a fresh scan with “rescan yes” in nmcli.
# nmcli’s “terse” output format (-t) uses colons between fields, which is easier to parse:
mapfile -t raw_lines < <( nmcli -t -f SSID,SECURITY,SIGNAL dev wifi list ifname "$iface" rescan yes )

# Remove any blank-SSID entries (hidden networks appear as empty SSID)
declare -a entries
for line in "${raw_lines[@]}"; do
    IFS=: read -r ssid sec sig <<<"$line"
    # Skip hidden (empty SSID) or duplicates here; we’ll dedupe in the next step.
    if [ -n "$ssid" ]; then
        entries+=("$ssid:$sec:$sig")
    fi
done

if [ ${#entries[@]} -eq 0 ]; then
    notify-send "No Wi-Fi networks found on $iface"
    echo "No Wi-Fi networks found." >&2
    exit 1
fi

#### 3) Filter out duplicate SSIDs, keep the one with highest SIGNAL ####

# Sort by SSID (col1) ascending, SIGNAL (col3) descending, then pick first of each SSID
mapfile -t sorted_unique < <(
    printf "%s\n" "${entries[@]}" | \
    sort -t: -k1,1 -k3,3nr | \
    awk -F: '!seen[$1]++ {print}'
)

#### 4) Build the “menu list” with icon tags ####

# For fuzzel, we want each line as:   SSID\x00icon_name
# For fzf, we just want SSID alone (no icons).
declare -a menu_lines
# Also keep parallel arrays to know SECURITY/SIGNAL for the chosen SSID later:
declare -A SSID_to_SECURITY
declare -A SSID_to_SIGNAL

for record in "${sorted_unique[@]}"; do
    IFS=: read -r ssid sec sig <<<"$record"
    SSID_to_SECURITY["$ssid"]="$sec"
    SSID_to_SIGNAL["$ssid"]="$sig"

    # Choose an icon based on signal strength:
    #  0–24  → “network-wireless-signal-weak”
    # 25–49  → “network-wireless-signal-ok”
    # 50–74  → “network-wireless-signal-good”
    # 75–100 → “network-wireless-signal-excellent”
    if (( sig >= 75 )); then
        icon="network-wireless-signal-excellent-symbolic"
    elif (( sig >= 50 )); then
        icon="network-wireless-signal-good-symbolic"
    elif (( sig >= 25 )); then
        icon="network-wireless-signal-ok-symbolic"
    else
        icon="network-wireless-signal-weak-symbolic"
    fi

    # Build the fuzzel line: SSID<NULL>icon
    # fuzzel expects a literal \0 (null) between text and icon.
    # printf '\0' inserts a null byte.
    menu_lines+=("$(printf "%s\0%s" "$ssid" "$icon")")
done

#### 5) Show the menu (prefer fuzzel, fallback to fzf) ####

if command -v fuzzel &>/dev/null; then
    # fuzzel in dmenu mode automatically picks up null‐separated “text\x00icon”
    mapfile -t chosen < <(
        printf "%b\n" "${menu_lines[@]}" | fuzzel --dmenu --prompt "Wi-Fi ($iface): " 
    )
    # fuzzel in dmenu returns the line with “SSID<null>icon”. We only need the SSID portion:
    # If the user presses Esc or closes, fuzzel outputs nothing → chosen is empty
    if [ ${#chosen[@]} -eq 0 ]; then
        exit 0
    fi
    # Extract SSID up to the null byte:
    SSID=$(printf "%s" "${chosen[0]}" | tr '\0' '\n' | head -n1)
    used_menu="fuzzel"
else
    # fuzzel not available → try fzf
    if ! command -v fzf &>/dev/null; then
        echo "Error: Neither fuzzel nor fzf is installed." >&2
        notify-send "Need fuzzel or fzf to select network"
        exit 1
    fi
    # Just pass the SSIDs (no icons) to fzf
    mapfile -t just_ssids < <( printf "%s\n" "${!SSID_to_SIGNAL[@]}" )
    SSID=$(printf "%s\n" "${just_ssids[@]}" | fzf --prompt="Wi-Fi ($iface): " --height=10 )
    [ -z "$SSID" ] && exit 0
    used_menu="fzf"
fi

#### 6) Check network security and attempt connection ####

SEC="${SSID_to_SECURITY[$SSID]}"
SIG="${SSID_to_SIGNAL[$SSID]}"

if [[ "$SEC" == "--" || "$SEC" == "NONE" || "$SEC" == "open" ]]; then
    # Open network → no password needed
    if nmcli dev wifi connect "$SSID" ifname "$iface" &>/dev/null; then
        notify-send "Connected (open) → $SSID [signal: $SIG]" 
        exit 0
    else
        notify-send "Failed to connect (open) → $SSID"
        exit 1
    fi
else
    # Secured network (WPA/WPA2/WEP)
    # First, check if nmcli already has a connection profile named exactly "$SSID"
    if nmcli -t -f NAME,TYPE connection show | awk -F: '$2=="802-11-wireless" {print $1}' | grep -xqF "$SSID"; then
        # Try re-activating the existing connection
        if nmcli connection up "$SSID" &>/dev/null; then
            notify-send "Reconnected → $SSID [signal: $SIG]"
            exit 0
        else
            # Might be wrong password stored; fall back to “ask new password”
            :
        fi
    fi

    # If we reach here, we need to ask for a password
    if [ "$used_menu" = "fuzzel" ]; then
        pwd=$(fuzzel --password --prompt "Password for \"$SSID\": ")
        # If user canceled password prompt:
        [ -z "$pwd" ] && exit 0
    else
        # fzf mode: we don’t have a “--password” flag, so just use read -s
        echo -n "Password for \"$SSID\": "
        read -rs pwd
        echo     # newline after hidden input
        if [ -z "$pwd" ]; then
            exit 0
        fi
    fi

    # Attempt to connect (nmcli will create a new profile stored by SSID)
    if nmcli dev wifi connect "$SSID" password "$pwd" ifname "$iface" &>/dev/null; then
        notify-send "Connected → $SSID [signal: $SIG]"
        exit 0
    else
        notify-send "Failed to connect → $SSID (wrong password?)"
        exit 1
    fi
fi
