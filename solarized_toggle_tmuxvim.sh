#!/bin/bash
#===============================================================================
#     File: solarized_toggle_tmuxvim.sh
#  Created: 08/31/2016, 11:35
#   Author: Bernie Roesler
#
#  Description: Set tmux/vim to solarized light colors
#
#===============================================================================
# instead of toggle... take 
test_tmux_dark=$(sed -n "/@colors-solarized 'dark'/ p" $HOME/.tmux.conf)
test_tmux_light=$(sed -n "/@colors-solarized 'light'/ p" $HOME/.tmux.conf)

# if tmux is in dark mode, switch to light
if [ -n "$test_tmux_dark" ]; then
    # BSD sed requires "-i ''" (space after -i)
    # GNU sed DOES NOT take space after -i ("-i''")
    sed -i'' --follow-symlinks "/@colors-solarized 'dark'/ s/dark/light/" $HOME/.tmux.conf
elif [ -n "$test_tmux_light" ]; then
    # if tmux is in light mode, switch to dark
    sed -i'' --follow-symlinks "/@colors-solarized 'light'/ s/light/dark/" $HOME/.tmux.conf
fi

# Apply the changes
tmux source-file $HOME/.tmux.conf

test_vim_dark=$(sed -n "/set background=dark/ p" $HOME/.vimrc)
test_vim_light=$(sed -n "/set background=light/ p" $HOME/.vimrc)

# if vim is in dark mode, switch to light
if [ -n "$test_vim_dark" ]; then
    sed -i'' --follow-symlinks "/set background=dark/ s/dark/light/" $HOME/.vimrc
elif [ -n "$test_vim_light" ]; then
    # if vim is in light mode, switch to dark
    sed -i'' --follow-symlinks "/set background=light/ s/light/dark/" $HOME/.vimrc
fi
#===============================================================================
#===============================================================================
