choice=$(echo -e "󰜉 Reboot\n󰐥 Shutdown\n󰍃 Logout" | fuzzel --dmenu --prompt "Power: ")
case "$choice" in
  "󰜉 Reboot") systemctl reboot ;;
  "󰐥 Shutdown") systemctl poweroff ;;
  "󰍃 Logout") niri msg action quit ;;
esac
