#!/bin/bash
#==============================================================================
#    File: print2pdf.sh
# Created: 12/16/14
#  Author: Bernie Roesler
#
# Description: creates a pdf document from a plain text file
#
# Input: filename (incl extension) of text file
#
# Output: {filename - extension}.pdf
#
#==============================================================================

# Check input argument usage
function die { echo $1; exit 42; }
[[ $# != 1 ]] && die "Usage: $0 <plaintext file>"

TEXT_FILE=$1

# Check if file exists and is readable
[[ -r $TEXT_FILE ]] || die "$TEXT_FILE is not readable or does not exist."

# Strip extension and path from filename
path=$(dirname ${TEXT_FILE})    # remember relative path
FILE_ROOT=${TEXT_FILE%.*}       # strip extension

# Open in vim and add proper header, write to ps file
# NOTE: syntax will be b/w ONLY, colors only work when vim is opened in normal
#   mode, i.e. not batch mode
vim -E -s $TEXT_FILE <<EOF
:syntax on
:set printoptions=paper:letter,syntax:y,number:y,left:4pc
:set printheader=%<%f%h%m%=Page\ %N\ of\ %{line('$')/69+1}
:hardcopy > $FILE_ROOT.ps
:wq
EOF

# convert ps file to pdf ("14" ensures newest version)
ps2pdf14 $path/$FILE_ROOT.ps $path/$FILE_ROOT.pdf
[[ $? != 0 ]] && echo "Unable to create pdf."

# remove temp ps file
rm -f $path/$FILE_ROOT.ps

#==============================================================================
#==============================================================================
