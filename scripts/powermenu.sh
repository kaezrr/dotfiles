choice=$(echo -e "󰐥 Shutdown\n󰜉 Reboot\n󰍃 Logout\n Lock Screen" | fuzzel --dmenu)
case "$choice" in
  "󰐥 Shutdown") systemctl poweroff ;;
  "󰜉 Reboot") systemctl reboot ;;
  "󰍃 Logout") hyprctl dispatch exit ;;
  " Lock Screen") hyprlock ;;
esac
