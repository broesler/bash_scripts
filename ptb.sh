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

usage() {
    echo "Usage: $me [TMUX PANE] [ENDPAT]" 2>&1
}

if [ -z "$TMUX" ]; then
  echo "$me must be run inside tmux session!" 2>&1
  usage
  exit 1
fi

if [ "$#" -eq 0 ]; then
    echo "$me requires the tmux pane as an argument!" 2>&1
    usage
    exit 1
fi

# Take first argument as pane
tmuxswp="$1"

if [ "$#" -eq 2 ]; then
    endpat="$2"
else
    endpat='\[.*\]\$' # bash prompt
fi

# Copy ipython pane to current pane's stdout for parsing
# sed steps:
#   - On "Traceback" lines replace hold space with pattern space
#   - On non-empty lines, append to hold space
#   - When end of file reached, exchange hold and pattern space, print
#   - all other lines, delete pattern space (current line only)
# Finally, remove last line, leaving just the Traceback message!
# Capture up to 32,768 lines of the buffer
tpane=$(tmux capture-pane -S -32768 -t "$tmuxswp" -p)
if [ -z "$endpat" ]; then
    echo "$tpane" | sed '/Traceback/h;//!H;${x;p};d' | sed '$d'
else
    echo "$tpane" | sed "/Traceback/{:1;/${endpat}/!{N;b1};h};\${x;p};d" | sed '$d'
fi

exit 0
#===============================================================================
#===============================================================================
