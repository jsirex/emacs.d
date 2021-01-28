#!/usr/bin/bash

# Launch emacs using scripts directory as emacs init directory
# Using git you can add several worktrees and run emacs directly from it

EMACS_DIR=$(cd $(dirname "$0"); pwd)
echo "Launching emacs using ${EMACS_DIR} as init directory"

emacs --chdir "${EMACS_DIR}" --init-directory "${EMACS_DIR}" --debug-init \
      --cursor-color red --title "DEVELOPING MODE" $@
