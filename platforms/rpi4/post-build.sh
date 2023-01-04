#!/bin/bash
set -u

cp $BR2_EXTERNAL_NODEROOT_PATH/platforms/rpi4/cmdline.txt \
  $BINARIES_DIR/rpi-firmware/cmdline.txt

mkdir -p $TARGET_DIR/root/.ssh
touch $TARGET_DIR/root/.ssh/authorized_keys

find $BR2_EXTERNAL_NODEROOT_PATH/pubkeys -type f |
  while read key; do
    cat $key >> $TARGET_DIR/root/.ssh/authorized_keys
  done
