#!/bin/bash
# vim with server (for LaTeX + Skim use)
test=$(command vim --version | grep -w clientserver)
if [ "$test" ]; then
    servers=( $(command vim --serverlist) )

    if [ $# -eq 0 ]; then
        # No need to issue a remote command for no filename
        command vim --servername VIM
    else
        # Use servername "VIM" to work with Skim inverse-search command
        # command vim --servername VIM --remote-silent "$@"
        # --remote-silent ONLY accepts filenames or a single command, eliminate
        # it to accept any arguments (i.e. '-S Session.vim')
        # however... if we don't use --remote-silent, we will start a new server
        # with the name "VIM1", "VIM2", etc. if we call the command multiple
        # times.
        command vim --servername VIM "$@"
    fi
else
    command vim "$@"      # ensure no server used
fi
