#!/bin/bash

# Get current power profile
power_profile=$(powerprofilesctl get)

# Get current refresh rate
refresh_line=$(hyprctl monitors | grep -A 1 "Monitor $MONITOR_NAME" | grep '@')
refresh_rate=$(echo "$refresh_line" | grep -oP '@\K[0-9.]+' | cut -d'.' -f1)

# Prompt string
status="⚡ $power_profile |  ${refresh_rate}Hz"

# Show menu
choice=$(echo -e \
        "󰓅 Performance\n󰾪 Balanced\n󰾫 Power Saver\n󰍹 Set 60Hz\n󰍸 Set 120Hz" | \
    fuzzel --dmenu --placeholder="$status")

# Act based on choice
case "$choice" in
    "󰓅 Performance") powerprofilesctl set performance ;;
    "󰾪 Balanced") powerprofilesctl set balanced ;;
    "󰾫 Power Saver") powerprofilesctl set power-saver ;;
    "󰍹 Set 60Hz") hyprctl keyword monitor ",1920x1080@60,auto,1.0" ;;
    "󰍸 Set 120Hz") hyprctl keyword monitor ",1920x1080@120,auto,1.0" ;;
esac
