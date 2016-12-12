#!/bin/bash
# ssh to babylon x
# Check if we're already in ssh session
if [ -z "$SSH_TTY" ]; then
    # connecting from plain terminal
    command ssh -X d26725q@babylon$1.thayer.dartmouth.edu
else
    read -p "Warning: Aready in SSH session. Ok to nest? [yn] >" > choice
    case $choice in
        y)
            # connecting from plain terminal
            command ssh -X d26725q@babylon$1.thayer.dartmouth.edu
            ;;
        *)
            return 0
    esac
fi
