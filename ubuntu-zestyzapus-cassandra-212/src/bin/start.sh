#!/usr/bin/env bash


#Cassandra configuration

# Accept listen_address
IP=${LISTEN_ADDRESS:-`hostname --ip-address`}

# Accept seeds via docker run -e SEEDS=seed1,seed2,...
SEEDS=${SEEDS:-$IP}

# Maps a base folder to where the data folders of cassandra are mapped
DATA_FOLDER_DATADIR=/data/cassandra/data
DATA_FOLDER_COMMITLOGDIR=/data/cassandra/commitlog
DATA_FOLDER_SAVEDCASHESDIR=/data/cassandra/saved_caches

# Backwards compatibility with older scripts that just passed the seed in
if [ $# == 1 ]; then SEEDS="$1,$SEEDS"; fi

#if this container was linked to any other cassandra nodes, use them as seeds as well.
if [[ `env | grep _PORT_9042_TCP_ADDR` ]]; then
  SEEDS="$SEEDS,$(env | grep _PORT_9042_TCP_ADDR | sed 's/.*_PORT_9042_TCP_ADDR=//g' | sed -e :a -e N -e 's/\n/,/' -e ta)"
fi

echo Configuring Cassandra to listen at $IP with seeds $SEEDS

# Setup Cassandra
CONFIG=/opt/apache-cassandra-2.1.12/conf

#rm -rf $CONFIG && cp -r $DEFAULT $CONFIG
sed -i -e "s/^listen_address.*/listen_address: $IP/"            $CONFIG/cassandra.yaml
sed -i -e "s/^rpc_address.*/rpc_address: 0.0.0.0/"              $CONFIG/cassandra.yaml
sed -i -e "s/# broadcast_address.*/broadcast_address: $IP/"              $CONFIG/cassandra.yaml
sed -i -e "s/# broadcast_rpc_address.*/broadcast_rpc_address: $IP/"              $CONFIG/cassandra.yaml
sed -i -e "s/^commitlog_segment_size_in_mb.*/commitlog_segment_size_in_mb: 64/"              $CONFIG/cassandra.yaml
sed -i -e "s/- seeds: \"127.0.0.1\"/- seeds: \"$SEEDS\"/"       $CONFIG/cassandra.yaml
sed -i -e "s/# JVM_OPTS=\"\$JVM_OPTS -Djava.rmi.server.hostname=<public name>\"/JVM_OPTS=\"\$JVM_OPTS -Djava.rmi.server.hostname=$IP\"/" $CONFIG/cassandra-env.sh
sed -i -e "s/LOCAL_JMX=yes/LOCAL_JMX=no/" $CONFIG/cassandra-env.sh
sed -i -e "s/JVM_OPTS=\"\$JVM_OPTS -Dcom.sun.management.jmxremote.authenticate=true\"/JVM_OPTS=\"\$JVM_OPTS -Dcom.sun.management.jmxremote.authenticate=false\"/" $CONFIG/cassandra-env.sh

echo "Using mapped data folder $DATA_FOLDER"

DATA_FOLDER_DATADIR=$(echo $DATA_FOLDER_DATADIR | sed 's/\//\\\//g')
DATA_FOLDER_COMMITLOGDIR=$(echo $DATA_FOLDER_COMMITLOGDIR | sed 's/\//\\\//g')
DATA_FOLDER_SAVEDCASHESDIR=$(echo $DATA_FOLDER_SAVEDCASHESDIR | sed 's/\//\\\//g')

sed -i -e "/^# data_file_directories:/{n;s/.*/data_file_directories:\n  - $DATA_FOLDER_DATADIR/}" $CONFIG/cassandra.yaml
sed -i -e "s/^# commitlog_directory:.*/commitlog_directory: \"$DATA_FOLDER_COMMITLOGDIR\"/"   $CONFIG/cassandra.yaml
sed -i -e "s/^# saved_caches_directory:.*/saved_caches_directory: \"$DATA_FOLDER_SAVEDCASHESDIR\"/"     $CONFIG/cassandra.yaml


if [[ $SNITCH ]]; then
  sed -i -e "s/endpoint_snitch: SimpleSnitch/endpoint_snitch: $SNITCH/" $CONFIG/cassandra.yaml
fi
if [[ $DC && $RACK ]]; then
  echo "dc=$DC" > $CONFIG/cassandra-rackdc.properties
  echo "rack=$RACK" >> $CONFIG/cassandra-rackdc.properties
fi

# Start process
echo Starting supervisor with Cassandra
/usr/bin/supervisord -c /etc/supervisord.conf
