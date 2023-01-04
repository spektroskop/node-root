#!/bin/sh
set -u

device=/dev/mmcblk0
apply="fwup --apply --no-unmount -d $device --task"
active=$(/usr/lib/system/partition.sh)

case "$active" in
  "1") $apply activate-2 && reboot ;;
  "2") $apply activate-1 && reboot ;;
esac
