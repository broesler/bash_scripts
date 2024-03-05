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
cat <<\EOF | clang -o $binary -x c -
#include <stdio.h>
int main() {
    printf("char   = %lu bytes\n", sizeof(char));
    printf("short  = %lu bytes\n", sizeof(short));
    printf("int    = %lu bytes\n", sizeof(int));
    printf("long   = %lu bytes\n", sizeof(long));
    printf("long long = %lu bytes\n", sizeof(long long));
    printf("float  = %lu bytes\n", sizeof(float));
    printf("double = %lu bytes\n", sizeof(double));
    printf("long double = %lu bytes\n", sizeof(long double));
}
EOF
$binary
rm $binary
#===============================================================================
#===============================================================================
