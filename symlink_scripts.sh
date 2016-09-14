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

# Symlink each file to correct file (adding . to filename)
for f in "${files[@]}";
do
  # exclude README and this script 
  if [[ $f != README.* ]] && [[ $f != $(basename $0) ]]  
  then
    file=$(basename "$f")
    filebase="${file%.*}"

    if [ "$1" == "-f" ]; then
      # symlink files, do not follow symbolic links that already exist 
      # (i.e. directories)
      command ln -nsvf $HOME/src/bash_scripts/"$f" $HOME/bin/"$filebase"
    else
      # Check before overwriting
      command ln -nsvi $HOME/src/bash_scripts/"$f" $HOME/bin/"$filebase"
    fi
  fi
done

exit 0
#==============================================================================
#==============================================================================
