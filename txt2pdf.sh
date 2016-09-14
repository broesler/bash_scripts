#!/bin/bash
# convert text file to pdf
enscript $1 -p temp.ps    # convert to postscript
ps2pdf temp.ps $1.pdf     # convert to pdf
rm -f temp.ps
