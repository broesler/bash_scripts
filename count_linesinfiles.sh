#!/bin/bash
#==============================================================================
#    File: count_linesinfiles.sh
# Created: 06/17/2014
#  Author: Bernie Roesler
#
# Description: Counts the number of ordinary files (not directories) in the
#   current working directory and its sub-directories. For each ordinary file
#   found, counts the number of lines in the file and prints the total number
#   of lines for files in the directory tree rooted at the current working
#   directory.
#
# Input: None.
#
# Output: Count of lines in each file in the directory tree, and total files.
#   Example:
#   ./count.sh
#   Counting lines of all files...
#   23 ./count.sh
#   1  ./a.java
#   24 Total
#   *************************
#   Number of files found: 2
#   *************************
#
#==============================================================================
files=($(find .))        # Create array of all file paths

tot=0                   # track total files
lines=0                 # track total lines

echo Counting lines of all files...
for f in ${files[@]}    # Loop over each file
do
  if [ -f $f ]          # If file is regular file (not a directory)
  then
    lc=$(wc -l $f | awk '{print $1}')  # get ONLY the number of lines
    # lines=$(expr $lines + $lc)         # add to total
    let "lines += $lc"         # add to total

    printf "%6s  %s\n" "$lc" "$f"  # display output
    let tot++
  fi
done

printf "%6d  Total lines\n\n" "$lines"
printf "****************************\n"
printf "Number of files found: %d \n" "$tot"
printf "****************************\n"

exit 0
