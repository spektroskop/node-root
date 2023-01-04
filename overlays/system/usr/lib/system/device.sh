#!/bin/sh
set -u

for ((n=0; n<50; n++)); do
  [ -b $1 ] && exit
  sleep 0.1
done
