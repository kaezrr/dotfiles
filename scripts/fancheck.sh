#!/bin/bash

sensors_output=$(sensors)

proc_rpm=$(echo "$sensors_output" | grep "Processor Fan" | sed -E 's/.*Processor Fan:\s*([0-9]+) RPM.*/\1/')
mobo_rpm=$(echo "$sensors_output" | grep "Motherboard Fan" | sed -E 's/.*Motherboard Fan:\s*([0-9]+) RPM.*/\1/')

proc_rpm=${proc_rpm:-0}
mobo_rpm=${mobo_rpm:-0}

if [[ $proc_rpm -gt 0 || $mobo_rpm -gt 0 ]]; then
    status="on"
else
    status="off"
fi

jq --unbuffered --compact-output -n \
  --arg alt "$status" \
  --arg tooltip "CPU Fan: ${proc_rpm} RPM&#10;GPU Fan: ${mobo_rpm} RPM" \
  --arg class "$status" \
  '{
    alt: $alt,
    tooltip: $tooltip,
    class: $class
  }'
