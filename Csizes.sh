#!/bin/bash
#===============================================================================
#     File: test.sh
#  Created: 12/05/2016, 14:19
#   Author: Bernie Roesler
#
#  Description: 
#
#===============================================================================
binary=$(mktemp)
cat <<\EOF | cc -o $binary -x c -
#include <stdio.h>
int main() {
    printf("int=%lu bytes\n", sizeof(int));
    printf("long=%lu bytes\n", sizeof(long));
}
EOF
$binary
rm $binary
#===============================================================================
#===============================================================================
