#!/bin/bash
# Attach to existing tmux session rather than create a new one if possible

# If given any arguments, just use them as they are
if (($#)) ; then
    args="$@"
elif command tmux has-session 2>/dev/null ; then
    args="attach-session -d"
else
    args="new-session -s \"${TMUX_SESSION:-default}\""
fi

# Force tmux to use 256 colors with -2 option (get solarized right)
command tmux -2 $args
