#!/bin/bash
set -e

if [ ! -z "$A2ENMOD" ]; then
    IFS=',' read -r -a array <<< "$A2ENMOD"
    for mod in "${array[@]}"; do
	echo "enabling module $mod"
	a2enmod $mod
    done
fi

exec "$@"
