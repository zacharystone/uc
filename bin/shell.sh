#!/bin/bash

export TERM=xterm-color
export TZ=Europe/Berlin

# hack to get ip
uco_ip=$(cat /etc/hosts | grep '\buco\b' | awk '{print $1}')

cat /etc/tor/torsocks.conf.in \
  | sed "s|TorAddress uco|TorAddress ${uco_ip}|" \
  > /tmp/torsocks.conf
export TORSOCKS_CONF_FILE=/tmp/torsocks.conf
# /usr/sbin/tor -f /etc/tor/torrc &
sleep 5

ssh-agent > /tmp/agent.tmp
. /tmp/agent.tmp
rm /tmp/agent.tmp

. torsocks on

bash