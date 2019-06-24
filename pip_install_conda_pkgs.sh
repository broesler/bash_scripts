#!/bin/bash
#===============================================================================
#     File: pip_install_conda_pkgs.sh
#  Created: 02/22/2018, 23:29
#   Author: Bernie Roesler
#
#  Description: Install same python packages that anaconda does
#
#===============================================================================

pkg_file="$HOME/src/bash/conda_pkgs.txt"

while read -r pkg || [ -n "$pkg" ]; do
    pip3 install --upgrade "$pkg"
    # pip3 uninstall -y "$pkg"
done < "$pkg_file"
#===============================================================================
#===============================================================================
