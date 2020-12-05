#!/bin/bash

echo 'a9ebfa600ece03fb0005080c3b1184dfe52cea87  /root/.netbox-scanner.conf' | sha1sum -c &> /dev/null && {
	echo -e "Error: You have to configure at least ADDRESS, TOKEN and NETWORKS in '.netbox-scanner.conf'.\n" >&2
	exit 1
}

echo 'Netbox-scanner running..'

exec python3 /netbox-scanner/netbox-scanner-438016caea3e975ce2cae34c443d661ee7b66b20/netbox-scanner/nbscanner
