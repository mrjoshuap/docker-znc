#! /usr/bin/env bash

# Options.
DATADIR="/var/lib/znc"

# Create default config if it doesn't exist
if [ ! -f "${DATADIR}/configs/znc.conf" ]; then
  mkdir -p "${DATADIR}/configs"
  cp /znc.conf.default "${DATADIR}/configs/znc.conf"
fi

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

