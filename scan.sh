#!/bin/bash

set -ueo pipefail

TAG="casperklein/netbox-scanner:latest"

DIR=${0%/*}
cd "$DIR"

echo "Starting Netbox-Scanner.."
docker run "$@" --rm -it -v "$PWD"/netbox-scanner.conf:/root/.netbox-scanner.conf:ro -v "$PWD"/networks.txt:/netbox-scanner/networks.txt:ro "$TAG"
