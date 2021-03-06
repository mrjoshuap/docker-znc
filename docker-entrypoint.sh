#! /usr/bin/env bash

# Magic.
tree ${DATADIR}

/bin/whoami
/bin/id

if [ "$1" = "bash" ]; then
  # gimme a shell
  /bin/bash
elif [ "$1" = "liveness" ]; then
  ps -ef | grep znc | grep -v 'ps -ef' || exit 1
  exit 0
else
  # start znc

  # Build modules from source.
  if [ -d "${DATADIR}/modules" ]; then
    # Store current directory.
    cwd="$(pwd)"

    # Find module sources.
    modules=$(find "${DATADIR}/modules" -name "*.cpp")

    # Build modules.
    for module in $modules; do
      echo "Building module $module..."
      cd "$(dirname "$module")"
      znc-buildmod "$module"
    done

    # Go back to original directory.
    cd "$cwd"
  fi

  # Create default config if it doesn't exist
  if [ ! -f "${DATADIR}/configs/znc.conf" ]; then
    echo "Creating a default configuration..."
    mkdir -p "${DATADIR}/configs"
    cp /znc.conf.default "${DATADIR}/configs/znc.conf"
  fi

  # Create a self-signed cert if required
  if [[ ! -f "${DATADIR}/znc.pem" ]]; then
    openssl req -x509 -newkey rsa:4096 -nodes -keyout key.pem -out cert.pem -days 1001
    cat key.pem cert.pem > "${DATADIR}/znc.pem"
  fi

  # Make sure $DATADIR is owned by znc user. This effects ownership of the
  # mounted directory on the host machine too.
  echo "Setting necessary permissions..."
  chown -R znc:znc "$DATADIR"

  # Start ZNC.
  echo "Starting ZNC..."
  exec znc --foreground --debug --datadir="$DATADIR" $@

fi
