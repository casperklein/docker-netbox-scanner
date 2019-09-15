#!/bin/bash

USER=casperklein
NAME=netbox-scanner
TAG=latest

[ -n "$USER" ] && TAG=$USER/$NAME:$TAG || TAG=$NAME:$TAG

DIR=$(dirname "$(readlink -f "$0")") &&
cd "$DIR" &&
docker run --rm -it -v "$(pwd)"/.netbox-scanner.conf:/root/.netbox-scanner.conf:ro $TAG
