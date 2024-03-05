#!/usr/bin/env bash
# Recent history (show command number and command, exclude time)
# number of commands to print
if (($#)); then
    n=$1
else
    n=10
fi

# Print n commands with decreasing index for use in !-# construction
# NOTE: `i=4' depends on the HISTTIMEFORMAT="%F %T " set in .bashrc
history $n |\
    awk -v j=$n \
    '{
        s="" 
        for (i=4; i<=NF; i++) {
            s = s $i " "
        }
        printf "%3.0d  %s\n", j, s
        j--
    }'
# Replace `printf' line with this one to include actual history index:
# printf "%2.0d %5.0d  %s\n", j, $1, s
