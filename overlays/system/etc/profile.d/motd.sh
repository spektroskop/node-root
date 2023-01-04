#!/bin/sh

active=$(/usr/lib/system/partition.sh)

cat <<-END

Partition: ${active:-N/A}

END
