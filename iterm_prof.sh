#!/bin/bash
#===============================================================================
#     File: iterm_prof.sh
#  Created: 02/07/2017, 21:36
#   Author: Bernie Roesler
#
#  Description: Set profile used in iTerm2
#
#===============================================================================

if [[ "$TERM_PROGRAM" != iTerm* ]] && \
   [[ "$(tmux display -p '#{client_termtype}')"  != iTerm* ]]
then
    printf "Warning: Profile switching not available outside of iTerm.app.\n" 1>&2
    exit 1
fi

# See <https://iterm2.com/documentation-escape-codes.html>
iterm_cmd="\e]1337;SetProfile=${1}\a"

# Apply change
if [ -n "$TMUX" ]; then
    # Use second escape sequence if we're in tmux
    printf "\ePtmux;\e${iterm_cmd}\e\\" 
else
    printf "$iterm_cmd"
fi

# Also change vim/tmux profiles to match
case "$1" in
    SolarizedDark)
        solarized_colors_tmuxvim dark
        ;;
    SolarizedLight)
        solarized_colors_tmuxvim light
        ;;
    *)
        # includes no arguments (for now)
        solarized_colors_tmuxvim 256
        ;;
esac

#===============================================================================
#===============================================================================
