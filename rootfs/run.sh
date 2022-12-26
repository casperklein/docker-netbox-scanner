#!/bin/bash

set -ueo pipefail

if [ ! -s /netbox-scanner/networks.txt ]; then
	echo "Error: 'networks.txt' is empty."
	echo
	exit 1
fi >&2

if echo '4de64ad74607f128bdb5873497a9d85d27e52c0a96dc994016488d050a55dd6c  /root/.netbox-scanner.conf' | sha256sum --check --status; then
	echo "Error: You have to configure at least ADDRESS and TOKEN in 'netbox-scanner.conf'."
	echo
	exit 1
fi >&2

cd /netbox-scanner

./nmap-scan.sh
