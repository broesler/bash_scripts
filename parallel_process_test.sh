#!/usr/bin/env bash
#===============================================================================
#     File: parallel_process_test.sh
#  Created: 02/15/2017, 15:25
#   Author: Bernie Roesler
#
#  Description: Test methods of running parallel processes in bash 
#
#===============================================================================

if [[ $# -eq 0 ]]; then
    opt=1
else
    opt=$1
fi

# Test function
echo_nums()
{
    for ((i="$1"; i<="$1"+4; i++));
    do 
        echo $i
        echo "error $i" 1>&2
        sleep 1
    done
}
export -f echo_nums

# Run in parallel
case $opt in
    #--------------------------------------------------------------------------- 
    #        (1) Simple bash loop
    #---------------------------------------------------------------------------
    # -- Most straightforward method using basic bash syntax
    # -- If we're piping/logging output, it works great
    1)
        for j in 1 21 56; do
            # Correct order of output: '>' no display, '| tee' for display:
            (echo_nums $j 2>&1) > test_$j.log &
            # Log just the stdout, display just the stderr:
            # (echo_nums $j > test_$j.log) 2>&1 &
            # echo_nums $j 2>&1 > test_$j.log &
            # Log just the stderr, display just the stdout:
            # echo_nums $j 2> test_$j.log &
        done
        wait
        ;;

    #--------------------------------------------------------------------------- 
    #        (2) using xargs
    #---------------------------------------------------------------------------
    # -- a bit more obscure, since inputs need newline characters to separate
    # -- would work great using filenames as inputs piped from find
    # -- output jumbled unless we redirect
    2)
        printf "1\n21\n56" \
            | xargs -n1 -P3 -I{} bash -c "echo_nums {} 2>&1 | tee test_{}.log"
        ;;

    #--------------------------------------------------------------------------- 
    #        (3) using parallel
    #---------------------------------------------------------------------------
    # -- naturally collates output unless we do redirection
    # -- non-standard syntax
    # -- obnoxious citation message on first run
    3)
        parallel 'echo_nums {} 2>&1 | tee test_{}.log' ::: 1 21 56
        ;;
    *)
        echo "Case unrecognized!" 1>&2
        exit 1
        ;;
esac

echo "All processes complete!"
#===============================================================================
#===============================================================================
