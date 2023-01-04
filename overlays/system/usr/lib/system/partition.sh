#!/bin/sh
set -u

fw_printenv | grep active-partition | cut -d= -f2 | xargs
