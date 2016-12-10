#!/bin/bash
#==============================================================================
#    File: symlink_scripts.sh
# Created: 09/14/2016, 13:17
#  Author: Bernie Roesler
#
# Description: Creates symlinks to ~/bin/ from ~/src/bash_scripts/
#==============================================================================

# Array of files in directory
files=(*.sh)

# Full path to this script (and scripts to be symlinked)
script_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P )

# symlink files, do not follow symbolic links that already exist (i.e. directories)
if [ "$1" == "-f" ]; then
    opts="-nsvf"            # force link creation
else
    opts="-nsvi"            # Check before overwriting
fi

if [ -n "$2" ]; then
    bin_path="$2"
else
    bin_path="$HOME/bin"
fi

# Symlink each file to correct file (adding . to filename)
for f in "${files[@]}";
do
    # exclude README and this script 
    if [[ $f != README.* ]] && [[ $f != $(basename $0) ]]  
    then
        file=$(basename "$f")
        filebase="${file%.*}"

        # symlink file
        command ln $opts "$script_path/$f" "$bin_path/$filebase"
    fi
done

exit 0
#==============================================================================
#==============================================================================
