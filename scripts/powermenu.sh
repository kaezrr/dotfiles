choice=$(echo -e "󰜉 Reboot\n󰐥 Shutdown\n󰍃 Logout\n Lock Screen" | fuzzel --dmenu --prompt "Power: ")
case "$choice" in
  "󰜉 Reboot") systemctl reboot ;;
  "󰐥 Shutdown") systemctl poweroff ;;
  "󰍃 Logout") hyprctl dispatch exit ;;
  " Lock Screen") hyprlock ;;
esac
