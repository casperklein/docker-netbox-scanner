#!/bin/bash

set -ueo pipefail

USER=$(grep -P 'ENV\s+USER=".+?"' Dockerfile | cut -d'"' -f2)
NAME=$(grep -P 'ENV\s+NAME=".+?"' Dockerfile | cut -d'"' -f2)
VERSION=$(grep -P 'ENV\s+VERSION=".+?"' Dockerfile | cut -d'"' -f2)
TAG="$USER/$NAME:$VERSION"

DIR=${0%/*}
cd "$DIR"

echo "Starting Netbox-Scanner.."
docker run "$@" --rm -it -v "$PWD"/netbox-scanner.conf:/root/.netbox-scanner.conf:ro -v "$PWD"/networks.txt:/netbox-scanner/networks.txt:ro "$TAG"
