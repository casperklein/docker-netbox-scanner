# docker-netbox-scanner

Docker version of [netbox-scanner](https://github.com/lopes/netbox-scanner). Scan networks and add them to Netbox.

## Build (optional)

    make

## Setup Netbox 2.x

1. Goto `Organization / Tags` and create a new tag: `nmap`.
1. Goto `Profile / API Tokens` and create a token, for use with netbox-scanner.

## Setup Netbox 3.x

1. Goto `Others / Tags` and create a new tag: `nmap`.
1. Goto `Profiles & Settings / API Tokens` and create a token, for use with netbox-scanner.

## Setup Netbox-Scanner

1. Configure *address* and API *token* in `netbox-scanner.conf`.
1. Configure the networks to scan in `networks.txt`.

## Start scan

    # use default DNS server
    ./scan.sh

    # use custom DNS server
    # usefull if the host has a public DNS server configured and reverse DNS is not working for scanned hosts on the local network
    ./scan.sh --dns 192.168.0.1
