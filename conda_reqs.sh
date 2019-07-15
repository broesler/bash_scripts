#!/usr/local/bin/bash
#===============================================================================
#     File: conda_reqs.sh
#  Created: 2019-07-07 16:46
#   Author: Bernie Roesler
#
#  Description: Install conda packages from either conda or pip
#
#===============================================================================

if [ $# -lt 1 ]; then
    filename='requirements.txt'
else
    filename="$1"
fi

# Try installing via conda first
while read req; do
    conda install "$req"
done < "$filename"

# Get the rest with pip
pip install -r "$filename"

exit 0
#===============================================================================
#===============================================================================
