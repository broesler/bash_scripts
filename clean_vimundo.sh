#!/bin/bash
#===============================================================================
#     File: clean_vimundo.sh
#  Created: 06/23/2017, 13:52
#   Author: Bernie Roesler
#
#  Description: Find undo files that do not correspond to actual files on disk
#  and remove those undo files
#
#===============================================================================

for undo_file in ${HOME}/.vim/tmp/undo/*
do 
    [ -e "$undo_file" ] || continue

    # undo filenames have '%' in place of '/'
    real_undofile=$(echo "$undo_file" | sed 's:%:/:g')

    # strip leading vim path to get actual file path
    real_file="${real_undofile#${HOME}/.vim/tmp/undo/}"

    # if we don't find real_file, remove the undo file
    if [ ! -e "$real_file" ]; then
        # echo "Deleting '$undo_file'..."
        rm -- "$undo_file"
    fi
done

#===============================================================================
#===============================================================================
