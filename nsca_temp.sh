#!/bin/bash
# nsca_temp.sh script to check Raspberry Pi CPU temp and send the data formatted 
# for use by NSCA for Nagios. 
#
# By George Jones for Corvex Connected

PLUGINS='/usr/lib/nagios/plugins'
SERVER=localhost #this is the nagios server's address/fqdn. In this case, we're using an ssh tunnel with the server being reachable via localhost

HOST=$HOSTNAME

SERVICE='passive_check_temp'
TEXT=$( ${PLUGINS}/check_rpi_temp.sh ) ;
RET=$?

echo -e "${HOST};${SERVICE};${RET};${TEXT}" | /usr/sbin/send_nsca -H $SERVER -p 5667 -d ";" -c /etc/send_nsca.cfg

exit 0
#eof
