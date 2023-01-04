#!/bin/sh
set -u

device=$1; root=$2; overlay=$3

mkdir $overlay
if ! mount $device $overlay; then
  mkfs.f2fs $device
  mount $device $overlay
fi

mkdir -p $overlay/upper
mkdir -p $overlay/work

mkdir $root
mount -t overlay overlay $root \
  -o lowerdir=/,upperdir=$overlay/upper,workdir=$overlay/work

mount -t devtmpfs devtmpfs $root/dev
mount -t sysfs sysfs $root/sys
mount -t proc proc $root/proc
