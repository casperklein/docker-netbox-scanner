# docker-netbox-scanner

Docker version of [netbox-scanner](https://github.com/lopes/netbox-scanner). Scan networks and add them to Netbox.

## Build (optional)

    make

## Setup Netbox

1. Goto `Organization / Tags` and create a new tag: `nmap`.
1. Goto `Profile / API Tokens` and create a token, for use with netbox-scanner.

## Setup Netbox-Scanner

1. Configure *address* and API *token* in `netbox-scanner.conf`.
1. Configure the networks to scan in `networks.txt`.

## Start scan

    make scan
