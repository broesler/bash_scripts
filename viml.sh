#!/bin/bash
# Open both tex and pdf file (in Skim) for editing

usage() {
    printf "Usage: viml [my_file.[tex|pdf]]\n" 1>&2
    exit 1
}

# Input argument checking
if [ "$#" -lt 1 ]; then
    usage
fi

# strip extension
f=$(basename "$1")
filebase=${f%.*}

texfile="${filebase}.tex" 
pdffile="${filebase}.pdf" 

if [ -e "$texfile" ]; then
    if [ -e "$pdffile" ]; then
        skim "$pdffile" &
        vims "$texfile"
    else
        echo "pdf file not found! Opening tex..." 1>&2
        vims "$texfile"
    fi
else
    usage
fi

exit 0
