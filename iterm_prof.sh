#!/bin/bash
#===============================================================================
#     File: iterm_prof.sh
#  Created: 02/07/2017, 21:36
#   Author: Bernie Roesler
#
#  Description: Set profile used in iTerm2
#
#===============================================================================
iterm_cmd="\e]1337;SetProfile=${1}\a"

if [ -n "$TMUX" ]; then
    # Use second escape sequence if we're in tmux
    printf "\ePtmux;\e${iterm_cmd}\e\\"
else
    printf "$iterm_cmd"
fi


#===============================================================================
#===============================================================================
