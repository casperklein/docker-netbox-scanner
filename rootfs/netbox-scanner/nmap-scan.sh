#!/usr/bin/env bash
#
# This is just an example.
#
# Since scanning many networks can produce huge XML files,
# the idea is to create one XML file per network, then
# use all of them as input to nbs.nmap.Nmap().
#
# If you scan few networks with few hosts or if you just
# want to experiment, feel free to use the `-iL` option of
# Nmap, passing a list of all networks and hosts to be
# scanned.
#
# If you have a large number of networks, use the mapfile option.
# In order to use mapfile, populate your networks, one per line,
# in a file called networks.txt.
#
# If you have a small number of networks, comment out the mapfile
# lines, and uncomment the "small array" line.
#
# For the purpose of this example, assume that netbox-scanner
# is configured to use the same directory of this script
# to look for XML files.
##

# mapfile
declare -a NETWORKS
mapfile -t NETWORKS < networks.txt

# small array
#NETWORKS="192.168.3.0/24 192.168.252.0/24"

for net in "${NETWORKS[@]}"; do
    echo "Scan network $net"
    NETNAME=$(echo $net | tr -s '/' '-')
    # -T<0-5>   Set timing template (higher is faster). The template names are paranoid (0), sneaky (1), polite (2), normal (3), aggressive (4), and insane (5).
    # -sn       Ping Scan - disable port scan
    # -PE       Use ICMP echo request queries
    # nmap "$net" -T4 -sn -PE --host-timeout 30s -oX nmap-"$NETNAME".xml
    nmap "$net" -sn -PE --host-timeout 30s -oX nmap-"$NETNAME".xml
done
echo

echo "Send networks to Netbox.."
python3 netbox-scanner.py nmap
