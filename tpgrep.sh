#!/bin/bash
#===============================================================================
#     File: tpgrep
#  Created: 11/25/2015, 19:29
#   Author: Bernie Roesler
#
# Last Modified: 02/22/2016, 22:51
#
#  Description: "[t]mux [p]s [g]rep" finds the tmux pane running the process
#  vim: set ft=sh syn=sh:
#===============================================================================

# if [ -z "$TMUX" ]; then
#     echo 'Usage: tpgrep must be run inside tmux session.' 1>&2
#     exit 1
# fi

# Declare error message function
usage() {
    local this_pane=$(tmux display-message -p \
        -F "#{session_id}:#{window_id}.#{pane_id}")
    echo "Usage: tpgrep [-t target-session] [pattern]"            1>&2
    echo "  tpgrep uses 'grep -sE [pattern]' to perform searches" 1>&2
    echo "  'tpgrep me' returns the current pane."                1>&2
    echo "  Current pane: ${this_pane}"                           1>&2
    exit 1
}

# Check if array contains element, takes 2 arguments "test_string" "${arr[@]}"
containsElement() {
    local e
    for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
    return 1
}

if [ "$#" -eq 0 ]; then
    usage
fi

target=''
session_flag=0

# Get arguments
while getopts ":h:t:s" opt; do
    case $opt in
        h)
            usage
            ;;
        t)
            target="$OPTARG"
            ;;
        s)
            session_flag=1
            ;;
        \?)
            echo "Invalid option: -$OPTARG" 1>&2
            usage
            ;;
        :)
            usage
            ;;
    esac
done

# shift the arguments to skip over the options to the real arguments (NOT
# including those assigned by $OPTARG above)
shift $((OPTIND-1))
args="$@"

# grep pattern, ignore all other arguments
tpg_pat="$1"

if [ -z "$tpg_pat" ]; then
    usage
fi

#-------------------------------------------------------------------------------
#        Check for target session
#-------------------------------------------------------------------------------
tmux_format="#{session_name} #{pane_tty} #{session_id} #{window_id} #{pane_id}"

if [ -z "$target" ]; then
    # Search ALL panes of ALL windows: pane tty, window id, pane id
    #  /dev/ttys001 $1 @5 %10 /dev/ttys002 $1 @5 %12
    lsp=$(tmux list-panes -a -F "${tmux_format}")
else
    # Check if target exists
    #     suppress tmux output "can't find window..." if one is not found
    if tmux has-session -t "${target}" 2>/dev/null; then
        if [ "$session_flag" -eq 1 ]; then
            tmux_com="tmux list-panes -s -t"
        else
            tmux_com="tmux list-panes -t"
        fi
        # NOTE no quotes on tmux_com so it is not taken as a single command
        lsp=$($tmux_com "${target}" -F "${tmux_format}")
    else
        # target session/window not found!
        exit 1
    fi
fi

# read ttys, windows, panes into arrays
sessname=( $(echo "$lsp" | \grep -o '^[^ ]*') )
panetty=(  $(echo "$lsp" | \grep -io 'tty.[0-9]\{3\}') )
sessid=(   $(echo "$lsp" | \grep -o '\$[0-9]\+') )
windowid=( $(echo "$lsp" | \grep -o '@[0-9]\+') )
paneid=(   $(echo "$lsp" | \grep -o '%[0-9]\+') )

# Build ps command to only list tty's in tmux
i=1
for pane in ${panetty[@]}; do
    pat+=" -t $pane"
    let i++
done

# grep for process running in one of the pane ttys
test=$(ps $pat | sed 1,1d | \grep -sE "$tpg_pat")

# NOTE: could possibly pgrep for PID. Need to match up to list of ttys. This
# line returns PID if tmux has the process, or empty string otherwise:
# test=$(pgrep -i $pat "$tpg_pat")

# extract tty of pane running process
# NOTE: if there are multiple instances of a process, tpgrep will find the
# tty with the *lowest* number, presumably the earliest-launched instance
if [ -n "$test" ]; then
    # array of ttys
    mtty=( $(echo "$test" | \grep -io "tty.[0-9]\{3\}") )

    # find array index matching mtty
    i=0
    for k in ${panetty[@]}; do
        if containsElement "$k" "${mtty[@]}"; then
            ind=$i
            break
        fi
        let i+=1
    done

    # extract window and pane ids of process
    sid=${sessid[$ind]}
    wid=${windowid[$ind]}
    pid=${paneid[$ind]}

    # Output to stdout
    echo "$sid:$wid.$pid"
fi

# No output if a match is not found
exit 0
#===============================================================================
#===============================================================================
