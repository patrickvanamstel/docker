#!/usr/bin/env bash

# Start process
echo Starting hazelcast and mancenter



IP=${LISTEN_ADDRESS:-`hostname --ip-address`}
echo this ip address is $IP

sed -i -e "s/<management-center enabled=\"false\">http:\/\/localhost:8080\/mancenter<\/management-center>/<management-center enabled=\"true\">http:\/\/${IP}:18080\/hazelcast-mancenter<\/management-center>/"   /opt/hazelcast-3.4.8/bin/hazelcast.xml 


/usr/bin/supervisord -c /etc/supervisord.conf
