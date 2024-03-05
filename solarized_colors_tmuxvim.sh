#!/usr/bin/env bash
#===============================================================================
#     File: solarized_colors_tmuxvim.sh
#  Created: 09/22/2016, 15:37
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

if [[ "$1" == 'dark' ||  "$1" == 'light' ]]; then
    # Set background to (dark|light), using non-degraded 16-color mode
    tmux_cval=$1
    vim_cval=$1
    ncol=16
elif [[ "$1" == '256' ]]; then
    # Set background to dark, using degraded 256-color mode
    tmux_cval=256
    vim_cval=dark
    ncol=256
else
    usage
fi

# Apply the changes
# NOTE: BSD sed requires "-i ''" (space after -i)
#       GNU sed DOES NOT take space after -i ("-i''")
sed -i'' --follow-symlinks "/@colors-solarized/ s/'[a-z0-9]\+'/'${tmux_cval}'/" $HOME/.tmux.conf
sed -i'' --follow-symlinks "/set background=/ s/=[a-z]\+/=${vim_cval}/" $HOME/.vimrc_solarized
sed -i'' --follow-symlinks "/let g:solarized_termcolors =/ s/= [0-9]\+/= ${ncol}/" $HOME/.vimrc_solarized

if [ -n "$TMUX" ]; then
    tmux source-file $HOME/.tmux.conf
fi

#===============================================================================
#===============================================================================
