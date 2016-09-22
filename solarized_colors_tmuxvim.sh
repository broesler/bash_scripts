#!/bin/bash
#===============================================================================
#     File: solarized_toggle_tmuxvim.sh
#  Created: 08/31/2016, 11:35
#   Author: Bernie Roesler
#
#  Description: Set tmux/vim to solarized light colors
#
#===============================================================================
# instead of toggle... take argument 'dark' 'light' '256'
usage() {
    printf "Usage: solarized_toggle_tmuxvim ['dark'|'light'|'256']\n" 1>&2
    exit 1
}

if [ $# -eq 0 ]; then
    usage
fi

# BSD sed requires "-i ''" (space after -i)
# GNU sed DOES NOT take space after -i ("-i''")
if [[ "$1" == "dark" ]]; then
    # Set background to dark, using non-degraded 16-color mode
    sed --follow-symlinks "/@colors-solarized/ s/'[a-z0-9]\+'/'dark'/" $HOME/.tmux.conf
    sed -i'' --follow-symlinks "/set background=/ s/=[a-z]\+/=dark/" $HOME/.vimrc
    sed -i'' --follow-symlinks "/let g:solarized_termcolors =/ s/= [0-9]\+/= 16/" $HOME/.vimrc
elif [[ "$1" == "light" ]]; then
    # Set background to light, using non-degraded 16-color mode
    sed -i'' --follow-symlinks "/@colors-solarized/ s/'[a-z0-9]\+'/'light'/" $HOME/.tmux.conf
    sed -i'' --follow-symlinks "/set background=/ s/=[a-z]\+/=light/" $HOME/.vimrc
    sed -i'' --follow-symlinks "/let g:solarized_termcolors =/ s/= [0-9]\+/= 16/" $HOME/.vimrc
elif [[ "$1" == "256" ]]; then
    # Set background to dark, using degraded 256-color mode
    sed -i'' --follow-symlinks "/@colors-solarized/ s/'[a-z0-9]\+'/'256'/" $HOME/.tmux.conf
    sed -i'' --follow-symlinks "/set background=/ s/=[a-z0-9]\+/=dark/" $HOME/.vimrc
    sed -i'' --follow-symlinks "/let g:solarized_termcolors =/ s/= [0-9]\+/= 256/" $HOME/.vimrc
else
    usage
fi

# Apply the changes
tmux source-file $HOME/.tmux.conf

#===============================================================================
#===============================================================================
