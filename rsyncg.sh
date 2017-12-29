#!/usr/local/bin/bash
#===============================================================================
#     File: rsyncg.sh
#  Created: 09/29/2017, 11:24
#   Author: Bernie Roesler
#
#  Description: rsync all files excluding those in the git repo
#
#===============================================================================

usage ()
{
    echo "Usage: $0 [OPTION] SRC [SRC] DEST"    1>&2
    echo "  See 'man rsync' for more options."  1>&2
    exit 1
}

if [ "$#" -lt 2 ]; then
    usage
fi

# If a local .gitignore file exists, 
# else use the global, 
# else just rsync all files
gitig=''
if [ -r '.gitignore' ]; then
    gitig="--include-from=.gitignore --exclude='*'"
elif [ -r "$HOME/.gitignore_global" ]; then
    echo "Warning! $0 is using .gitignore_global" 1>&2
    gitig="--include-from=$HOME/.gitignore_global --exclude='*'"
fi

# NOTE the order of "exclude"s and "include"s DOES matter!! See 'man rsync'.
# [c]hecksum of files, [r]ecursive, preserve sym[l]inks, prune e[m]pty
# directories, preserve [t]imestamp, [v]erbose, [z]ip files, and show [stats] at
# end of run
rsync -crlmtvz --stats     \
    --exclude='*.DS_Store' \
    --exclude='*Icon*'     \
    --exclude='.git/'      \
    --include='*/'         \
    $gitig                 \
    "$@"

#===============================================================================
#===============================================================================
