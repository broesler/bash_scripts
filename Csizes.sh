#!/bin/bash
#===============================================================================
#     File: Csizes.sh
#  Created: 12/05/2016, 14:19
#   Author: Bernie Roesler
#
#  Description: Write, compile and run a C program from a shell script
#
#===============================================================================
binary=$(mktemp)
cat <<\EOF | gcc-9 -o $binary -x c -
#include <stdio.h>
int main() {
    printf("char   = %lu bytes\n", sizeof(char));
    printf("int    = %lu bytes\n", sizeof(int));
    printf("long   = %lu bytes\n", sizeof(long));
    printf("long long = %llu bytes\n", sizeof(unsigned long long));
}
EOF
$binary
rm $binary
#===============================================================================
#===============================================================================
