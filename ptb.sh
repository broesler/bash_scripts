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
#   - Find "Traceback" line
#   - Set label :1
#   - Until we find a prompt ('>>>'), add next line to pattern space, and then
#     replace hold space with pattern space (gets last occurrence of Traceback)
#   - When end of file reached, exchange hold and pattern space, and print
#   - delete all other lines
# Finally, remove last line, leaving just the Traceback message!
output=$(tmux capture-pane -t "$tmuxswp"  -p \
    | sed '/Traceback/{:1;/>>>/!{N;b1};h};${x;p};d' \
    | sed '$d')

echo "$output"

exit 0
#===============================================================================
#===============================================================================
