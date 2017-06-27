#!/bin/bash
#===============================================================================
#     File: screen_test.sh
#  Created: 06/20/2017, 13:29
#   Author: Bernie Roesler
#
#  Description: Run a program in a detached screen session
#
#===============================================================================

if [ -z "$STY" ]; then exec screen -dm -S screenName /bin/bash "$0"; fi

for i in {1..60}; do
    sleep 1
    echo "$i"
done
