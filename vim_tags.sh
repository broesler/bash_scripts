#!/bin/bash
# Refresh the tags file with all of the vim and python scripts, excluding the
# tmp file with undo/swp files.
rm tags && ctags -R --exclude='vim/tmp/*' vim/**/*.vim  vim/**/*.py
