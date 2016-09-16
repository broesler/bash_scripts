#===============================================================================
#     File: fmo
#  Created: 12/17/2015, 23:40 
#   Author: Bernie Roesler
#
#  Description: [f]ormat [m]atlab [o]utput (when running in non-graphics mode)
#
#  vim: set ft=sh syn=sh tw=80:
#===============================================================================

if [ -z "$TMUX" ]; then
  echo "Usage: fmo must be run inside tmux session." 2>&1
  exit 1
fi

if [ "$#" -eq 0 ]; then
    echo "Usage: fmo requires the tmux pane as an argument." 2>&1
    exit 1
fi

# Take first argument as pane
tmuxswp="$1"

# Ensure Matlab has printed all commands (a bit hacky...)
# TODO check that last line of "tmux capture-pane..." is ">>" in case of
#   long-running programs
sleep 0.1

# Copy matlab pane to current pane's stdout for parsing
# Steps:
#  1. Remove blank lines
#  2. Reverse output to start search from most recent Matlab output
#  3. Find first empty command-prompt, print lines until first non-empty
#     command-prompt (i.e. last command issued), then exit
#  4. Reverse output again to get normal order
#  5. Edit output to include filenames of functions (will not work for multiple
#     functions defined within the same file!)
output=$(tmux capture-pane -t "$tmuxswp"  -p \
    | sed '/^\s*$/d' \
    | tac \
    | awk '/>> *$/{flag=1;next} />> [A-Za-z]/{flag=0;exit;} flag{print}' \
    | tac \
    | sed "s/[iI]n [^ ]*/&.m/")

echo "$output"

exit 0
#===============================================================================
#===============================================================================
