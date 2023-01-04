#!/bin/bash
set -u

$HOST_DIR/usr/bin/fwup --create \
  -f $BR2_EXTERNAL_NODEROOT_PATH/platforms/rpi4/fwup.conf \
  -o $BINARIES_DIR/system.fw
