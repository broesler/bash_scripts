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
    printf "%s\n" "Usage: $(basename $0) [OPTION] SRC [SRC] DEST"\
                  "   See 'man rsync' for more options." 1>&2
    exit 1
}

if [ "$#" -lt 2 ]; then
    usage
fi

# If a local and/or global .gitignore file exists, use it
# else just rsync all files
# TODO find all .gitignores in the repo:
#   1. Get toplevel directory
#   2. find "$toplevel" -name '.gitignore'
#   Possible issue: how does .gitignore respect paths?
#   Fix: Force this script to run from the top-level directory, but how to
#   determine which argument is the "local" directory?
gitig=()
if [ -r .gitignore ]; then
    gitig+=('--include-from=.gitignore')
fi

if [ -r "$HOME/.gitignore_global" ]; then
    gitig+=("--include-from=$HOME/.gitignore_global")
fi

# If we're using a gitignore, exclude all the other files in the directory
# NOTE the '*' does not get expanded by the double quotes below. A second set of
# double quotes would perform the next expansion
if [ -n "$gitig" ]; then
    gitig+=('--exclude=*')
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
    "${gitig[@]}"          \
    "$@"

#===============================================================================
#===============================================================================
