#!/usr/local/bin/bash
#===============================================================================
#     File: ptb.sh
#  Created: 05/18/2018, 00:55
#   Author: Bernie Roesler
#
#  Description: Get ipython traceback from tmux pane
#
#===============================================================================
me=$(basename $0)

if [ -z "$TMUX" ]; then
  echo "Usage: $me must be run inside tmux session." 2>&1
  exit 1
fi

if [ "$#" -eq 0 ]; then
    echo "Usage: $me requires the tmux pane as an argument." 2>&1
    exit 1
fi

# Take first argument as pane
tmuxswp="$1"

# Copy ipython pane to current pane's stdout for parsing
# sed steps:
#   - On "Traceback" lines replace hold space with pattern space
#   - On non-empty lines, append to hold space
#   - When end of file reached, exchange hold and pattern space, print
#   - delete all other lines
# Finally, remove last line, leaving just the Traceback message!
tpane=$(tmux capture-pane -t "$tmuxswp" -p)
echo "$tpane" | sed '/Traceback/h;//!H;${x;p};d' | sed '$d'

exit 0
#===============================================================================
#===============================================================================
