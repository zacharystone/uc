#!/bin/bash

export TZ=Europe/Paris

# Force bitlbee into local tor
# this should be using uco, but unfortunately
# dns is still resolved in ucd.
# torsocks.conf does not accept hostnames so its config
# could be scripted - further work needed
/usr/sbin/tor -f /etc/tor/torrc &
sleep 5
source torsocks on
/usr/sbin/bitlbee -n -v
