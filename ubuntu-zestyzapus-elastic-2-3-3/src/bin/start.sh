#!/usr/bin/env bash

if [ -z "$CLUSTER_NAME" ]
then
     CLUSTER_NAME="docker-elasticsearch-node"
fi

if [ -z "$NODE_NAME" ]
then
     NODE_NAME="docker-node-name"
fi

if [ -z "$ZEN_MINIMUM_MASTER_NODES" ]
then
     ZEN_MINIMUM_MASTER_NODES="#"
fi

if [ -z "$ZEN_PING_UNICAST" ]
then
	ZEN_PING_UNICAST="#"
fi


IP=${LISTEN_ADDRESS:-`hostname --ip-address`}



sed -i -e "s/^# cluster.name: my-application/cluster.name: ${CLUSTER_NAME}/"   /opt/elasticsearch-2.3.3/config/elasticsearch.yml
sed -i -e "s/^# node.name: node-1/node.name: ${NODE_NAME}/"   /opt/elasticsearch-2.3.3/config/elasticsearch.yml
sed -i -e "s/^# path.data: \/path\/to\/data/path.data: \/data\/data/"   /opt/elasticsearch-2.3.3/config/elasticsearch.yml
sed -i -e "s/^# path.logs: \/path\/to\/logs/path.logs: \/data\/logs/"   /opt/elasticsearch-2.3.3/config/elasticsearch.yml
sed -i -e "s/^# network.host: 192.168.0.1/network.host: 0.0.0.0/" /opt/elasticsearch-2.3.3/config/elasticsearch.yml

sed -i -e "s/^# discovery.zen.ping.unicast.hosts: \[\"host1\", \"host2\"\]/discovery.zen.ping.unicast.hosts: ${ZEN_PING_UNICAST}/"   /opt/elasticsearch-2.3.3/config/elasticsearch.yml
sed -i -e "s/^# discovery.zen.minimum_master_nodes: 3/discovery.zen.minimum_master_nodes: ${ZEN_MINIMUM_MASTER_NODES}/"   /opt/elasticsearch-2.3.3/config/elasticsearch.yml


sysctl -w vm.max_map_count=262144

# Start process
echo Starting Elasticsearch 2-3-3
/usr/bin/supervisord -c /etc/supervisord.conf
