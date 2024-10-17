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
    printf("char        = %lu bytes = %lu bits\n",   sizeof(char),          8*sizeof(char));
    printf("short       = %lu bytes = %lu bits\n",   sizeof(short),         8*sizeof(short));
    printf("int         = %lu bytes = %lu bits\n",   sizeof(int),           8*sizeof(int));
    printf("long        = %lu bytes = %lu bits\n",   sizeof(long),          8*sizeof(long));
    printf("long long   = %lu bytes = %lu bits\n",   sizeof(long long),     8*sizeof(long long));
    printf("float       = %lu bytes = %lu bits\n",   sizeof(float),         8*sizeof(float));
    printf("double      = %lu bytes = %lu bits\n",   sizeof(double),        8*sizeof(double));
    printf("long double = %lu bytes = %lu bits\n",   sizeof(long double),   8*sizeof(long double));
}
EOF
$binary
rm $binary
#===============================================================================
#===============================================================================
