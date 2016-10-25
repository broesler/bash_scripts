#!/bin/bash
#===============================================================================
#     File: tms
#  Created: 12/03/2015, 15:05 
#   Author: Bernie Roesler
#
# Last Modified: 02/22/2016, 21:49
#
#  Description: "[tm]ux [s]witch" switches to the tmux session:window.pane
#  vim: set ft=sh syn=sh:
#===============================================================================
if [ "$#" -gt 0 ]; then
    # TODO: insert argument checking to ensure $1:@1.%1 format...
    tmuxswp="$1"

    # Switch to session first, then window, then pane
    tmux switch -t "$tmuxswp" && \
    tmux select-window -t "$tmuxswp" && \
    tmux select-pane -t "$tmuxswp"

else
    echo "Usage: tms \$session:@window.%pane" 1>&2
    exit 0
fi

exit 0
#===============================================================================
#===============================================================================
