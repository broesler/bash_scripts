#!/usr/bin/env python3
# =============================================================================
#     File: edit_wintermprof.py
#  Created: 2023-07-26 14:52
#   Author: Bernie Roesler
#
"""
Switch between color schemes in the Windows Terminal settings.json file.
"""
# =============================================================================

import sys, json

settings_file = (
    '/mnt'
    '/c'
    '/Users'
    '/broesler'
    '/AppData'
    '/Local'
    '/Packages'
    '/Microsoft.WindowsTerminal_8wekyb3d8bbwe'
    '/LocalState'
    '/settings.json'
)

if __name__ == '__main__':
    try:
        cval = sys.argv[1]  # 'light', 'dark', '256'
    except IndexError:
        cval = 'dark'

    with open(settings_file, 'r') as fp:
        f = json.load(fp)

    prof = [p for p in f['profiles']['list'] if p['name'] == 'Ubuntu-22.04'][0]

    if cval in ['dark', '256']:
        prof['colorScheme'] = 'Ubuntu-22.04-ColorScheme'
    elif cval == 'light':
        prof['colorScheme'] = 'Solarized Light'
    else:
        raise ValueError(f"{cval = } not recognized!")

    with open(settings_file, 'w') as fp:
        json.dump(f, fp, indent=4)

# =============================================================================
# =============================================================================
