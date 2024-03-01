#!/usr/local/bin/bash
#===============================================================================
#     File: convert_to_md.sh
#  Created: 2021-01-22 22:15
#   Author: Bernie Roesler
#
#  Description: 
#
#===============================================================================

if [ $# -eq 0 ]; then
    printf "Usage: ./convert_to_md.sh <filename.tex>\n" 1>&2
    exit 1
fi

file="$1" 
shift
# Notes: 
#   * use github-flavored-markedown for Jekyll
#   * convert un-MathJax phrasing first, then pandoc it
sed -E 's/\\m(left|right)/\\\1/g' "$file" \
    | pandoc -f latex -t gfm+tex_math_dollars "$@" \
    | sed '/``` /,/# <<begin/{/``` /!d};/# <<end/,/```/{/```/!d}'

#===============================================================================
#===============================================================================
