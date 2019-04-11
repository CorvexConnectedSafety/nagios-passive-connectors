#nsca_mqtt for Nagios
#By George Jones for Corvex Connected
#Retrieve the active/inactive/unknonw status of Mosquitto and send it to the Nagios server.

#!/bin/bash

mqttstatus=$( systemctl is-active mosquitto )
cond1="active"
cond2="inactive"
cond3="unknown"

if [ "$mqttstatus" = "$cond1" ]; then
	echo "staff-ep;passive_check_mosquitto;0;OK - $mqttstatus" | /usr/sbin/send_nsca -H localhost -p 5667 -d ";" -c /etc/send_nsca.cfg
	exit 0
elif [ "$mqttstatus" = "$cond2" ]; then
        echo "staff-ep;passive_check_mosquitto;2;CRITICAL - $mqttstatus" | /usr/sbin/send_nsca -H localhost -p 5667 -d ";" -c /etc/send_nsca.cfg
        exit 2
elif [ "$mqttstatus" = "$cond3" ]; then
        echo "staff-ep;passive_check_mosquitto;3;UNKNOWN - $mqttstatus" | /usr/sbin/send_nsca -H localhost -p 5667 -d ";" -c /etc/send_nsca.cfg
        exit 3
fi

