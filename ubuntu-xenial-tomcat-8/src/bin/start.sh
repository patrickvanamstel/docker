#!/usr/bin/env bash


if [ -z "$CLUSTER_NAME" ]
then
     CLUSTER_NAME="docker-elasticsearch-node"
fi

sed -i -e "s/^cluster.name: elasticsearch/cluster.name: ${CLUSTER_NAME}/"   /opt/elasticsearch-0.19.9/config/elasticsearch.yml
sed -i -e "s/^# path.data: \/path\/to\/data1,\/path\/to\/data2/path.data: \/data\/data/"   /opt/elasticsearch-0.19.9/config/elasticsearch.yml
sed -i -e "s/^# path.logs: \/path\/to\/logs/path.logs: \/data\/logs/"   /opt/elasticsearch-0.19.9/config/elasticsearch.yml

# Start process
echo Starting Elasticsearch 0.19.9
/usr/bin/supervisord -c /etc/supervisord.conf
