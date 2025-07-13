#!/bin/bash

MAX_RPM=6900

sensors_output=$(sensors)

proc_rpm=$(echo "$sensors_output" | grep "Processor Fan" | sed -E 's/.*Processor Fan:\s*([0-9]+) RPM.*/\1/')
mobo_rpm=$(echo "$sensors_output" | grep "Motherboard Fan" | sed -E 's/.*Motherboard Fan:\s*([0-9]+) RPM.*/\1/')

proc_rpm=${proc_rpm:-0}
mobo_rpm=${mobo_rpm:-0}

# Use the higher of the two fans to represent overall cooling activity
max_rpm=$(( proc_rpm > mobo_rpm ? proc_rpm : mobo_rpm ))

# Clamp max RPM between 0 and MAX_RPM
clamped_rpm=$(( max_rpm > MAX_RPM ? MAX_RPM : max_rpm ))

# Calculate percentage
percentage=$(( clamped_rpm * 100 / MAX_RPM ))

# Determine status
if [[ $max_rpm -gt 0 ]]; then
    status="on"
else
    status="off"
fi

jq --unbuffered --compact-output -n \
    --arg alt "$status" \
    --arg tooltip "CPU Fan: ${proc_rpm} RPM&#10;GPU Fan: ${mobo_rpm} RPM" \
    --arg class "$status" \
    --argjson percentage "$percentage" \
    '{
    alt: $alt,
    tooltip: $tooltip,
    class: $class,
    percentage: $percentage
}'
