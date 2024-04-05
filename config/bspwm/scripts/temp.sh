#!/usr/bin/env bash

TEMP="$(cat /sys/devices/platform/coretemp.0/hwmon/hwmon4/temp1_input | awk '{print int($1/1000)}')"
echo "${TEMP:-null}"
