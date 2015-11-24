#! /usr/bin/env bash

tree ${DATADIR}

if [ "$1" = "bash" ]; then
  # gimme a shell
  /bin/bash
else
  # Start ZNC.
  znc --foreground --datadir="$DATADIR" $@
fi
