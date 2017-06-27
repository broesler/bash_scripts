#!/bin/bash
#==============================================================================
#    File: skimvim.sh
# Created: 04/01/2015
#  Author: Bernie Roesler
#
# Description: Called from Skim to open vim at synctex'd line location
#
# Input: filename and line number
#
# Output: opens vim in terminal window, if not already open
#
#==============================================================================

# Check input args
if [ $# -ne 2 ]
then
    printf "Usage: skimvim [file] [line]\n" 1>&2
    exit 1
fi

SVFILE="${HOME}/src/bash/skimvim.vim"

# Extract arguments
file="$1"
line="$2"

# Check if first line in file is a slash '/', if not, add path
[ "${file:0:1}" == "/" ] || file="${PWD}/$file"

# Call vimscript from commandline
# If file exists, remove it
[ -w ${SVFILE} ] && rm ${SVFILE}

# Write vimscript to be read
# Checks if buffer of file exists & changes to it or opens new buffer,
# then goes to line number
exec ${SVFILE} << EOF
  if bufexists('$file')
    exe ":buffer " . bufnr('$file')
  else
    edit ${file// /\ }
  endif
  $line
EOF

# Find out of vim is running already
VIMTEST=$(ps -A | grep '\<vim\>' | grep -v grep)
if [ "$?" -eq 0 ]; then
    fg vim
else
    vim -s ${SVFILE}
fi

exit 0
#==============================================================================
#==============================================================================
