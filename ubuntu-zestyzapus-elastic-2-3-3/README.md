# Ubuntu 17.04 (Zesty Zapus) with Elasticsearch 2.3.3

Running a single node elasticsearch

## Build

```
sudo docker build -t patrickvanamstel/ubuntu-zestyzapus-elastic-2-3-3 .
```

## Publish

Do publish this in the docker repo. This is not opensource software

```
sudo docker push patrickvanamstel/ubuntu-xenial-elastic-2-3-3 .
```

## Challenge
Docker has it's own network stack.

If you run in a network with ip address 192.168.x.x it cannot reach the default
docker address range of 172.17.0.x. This is normally blocked by the gateway.

From Docker version 1.10 there is a new possibility. It is called iptastic.


## Sample
Create the bridge
```
sudo docker network create --subnet 203.0.113.0/24 --gateway 203.0.113.254 iptastic
```

Start the container

```
sudo docker run --privileged --name elastic-2-3-3-n1 \
                   --net iptastic --ip 203.0.113.31 -v /data2/docker/containers/ubuntu-xenial-elastic-2-4-1-n1/data:/data \
                   -e CLUSTER_NAME='elasticsearch.2.3.3.pva' \
                   -e NODE_NAME='node1' \
                   -e ZEN_MINIMUM_MASTER_NODES='3' \
                   -e ZEN_PING_UNICAST='["203.0.113.32" ,"203.0.113.33" , "203.0.113.34"]' \
                   -it patrickvanamstel/ubuntu-zestyzapus-elastic-2-3-3 /bin/bash

```                   

Open browser for status of elastic
```
http://203.0.113.31:9200/
```


## Commands

## Cheatsheet
