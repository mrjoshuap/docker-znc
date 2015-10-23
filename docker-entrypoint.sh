#! /usr/bin/env bash

# Options.
DATADIR="${DATADIR:-/tmp/znc}"

tree ${DATADIR}

# Make sure $DATADIR is owned by znc user. This effects ownership of the
# mounted directory on the host machine too.
chown -R znc:znc "$DATADIR"

if [ "$1" = "bash" ]; then
  # gimme a shell
  /bin/bash
else
  # Start ZNC.
  znc --foreground --datadir="$DATADIR" $@
fi
