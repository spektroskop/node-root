#!/bin/sh
set -u

mount -t devtmpfs devtmpfs /dev
mount -t sysfs sysfs /sys
mount -t proc proc /proc

if (exec 0</dev/console) 2>/dev/null; then
  exec 0</dev/console
  exec 1>/dev/console
  exec 2>/dev/console
fi
