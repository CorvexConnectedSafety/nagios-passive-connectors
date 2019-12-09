#!/bin/bash
# nsca_alive.sh script to keep sending an "alive" message to show that the gateway is currently up and running.
# This will be displayed under "passive_check_alive" in Nagios for each of the gateway machines.
# for use by NSCA for Nagios.
#
# By George Jones for Corvex Connected

PLUGINS='/usr/lib/nagios/plugins'
SERVER=localhost #this is the nagios server's address/fqdn. In this case, we're using an ssh tunnel with the server being reachable via localhost

HOST=$HOSTNAME

SERVICE="passive_check_alive"
TEXT="Alive"

echo -e "${HOST};${SERVICE};0;${TEXT}" | /usr/sbin/send_nsca -H $SERVER -p 5667 -d ";" -c /etc/send_nsca.cfg

exit 0
