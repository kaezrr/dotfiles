#!/bin/bash

# === Configuration ===
HWMON_PATH="/sys/class/hwmon/hwmon5"  # Adjust if needed
CPU_FAN="pwm1"
GPU_FAN="pwm2"

# === Helper Functions ===
usage() {
  echo "Usage: sudo $0 [on|off]"
  exit 1
}

# === Input Validation ===
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root."
  exit 1
fi

if [ "$#" -ne 1 ]; then
  usage
fi

ACTION=$1

# === Fan Control Logic ===
write_pwm() {
  local fan=$1
  local value=$2
  local path="$HWMON_PATH/$fan"

  if [ ! -e "$path" ]; then
    echo "Error: $path not found. Check HWMON_PATH or fan name."
    exit 1
  fi

  echo "$value" > "$path"
  echo "Set $fan to $value"
}

case "$ACTION" in
  on)
    write_pwm "$CPU_FAN" 100
    write_pwm "$GPU_FAN" 100 
    ;;
  off)
    write_pwm "$CPU_FAN" 0
    write_pwm "$GPU_FAN" 0
    ;;
  *)
    echo "Invalid action: $ACTION"
    usage
    ;;
esac
