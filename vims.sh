#!/bin/bash
# vim with server (only for LaTeX + Skim really)
test=$(command vim --version | grep -w clientserver)
if [ "$test" ]; then
    if [ $# -eq 0 ]; then
        # No need to issue a remote command for no filename
        command vim --servername VIM
    else
        # Make compatible with Skim inverse-search command
        command vim --servername VIM --remote-silent "$@"
    fi
else
    command vim "$@"      # ensure no server used
fi
