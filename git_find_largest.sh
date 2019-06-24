#!/bin/bash
#===============================================================================
#     File: git_find_largest.sh
#  Created: 12/19/2016, 16:53
#
#  Description:  Shows you the largest objects in your repo's pack file
#       See: <http://stevelorek.com/how-to-shrink-a-git-repository.html>
#       Author: Antony Stubbs
#
#===============================================================================

# Take number of files to process
if [ $# -eq 1 ]; then
    n=$1
else
    n=10
fi

# set the internal field spereator to line break, so that we can iterate easily
# over the verify-pack output
IFS=$'\n';

# list all objects including their size, sort by size, take top 10
objects=$(git verify-pack -v .git/objects/pack/pack-*.idx | grep -v chain | sort -k3nr | head --lines="$n")

if [[ "$objects" == ".git/objects/pack/pack-*.pack: bad" ]]; then
    exit 1
fi

echo "All sizes are in kB. The pack column is the size of the object, compressed, inside the pack file."

output="size,pack,SHA,location"
for y in $objects
do
	# extract the size in bytes
	size=$((`echo $y | cut -f 5 -d ' '`/1024))
	# extract the compressed size in bytes
	compressedSize=$((`echo $y | cut -f 6 -d ' '`/1024))
	# extract the SHA
	sha=`echo $y | cut -f 1 -d ' '`
	# find the objects location in the repository tree
	other=`git rev-list --all --objects | grep $sha`
	#lineBreak=`echo -e "\n"`
	output="${output}\n${size},${compressedSize},${other}"
done

echo -e $output | column -t -s ','
#===============================================================================
#===============================================================================
