#Ubuntu 16.04 (Xenial) with Elasticsearch 0.19

Running a single node elasticsearch 

##Build

```
sudo docker build -t patrickvanamstel/ubuntu-xenial-elastic-0-19 .
```

##Publish

Do publish this in the docker repo. This is not opensource software

```
sudo docker push patrickvanamstel/ubuntu-xenial-elastic-0-19 .
```

##Challenge
Docker has it's own network stack.

If you run in a network with ip address 192.168.x.x it cannot reach the default
docker address range of 172.17.0.x. This is normally blocked by the gateway.

From Docker version 1.10 there is a new possibility. It is called iptastic.


##Sample
Create the bridge
```
sudo docker network create --subnet 203.0.113.0/24 --gateway 203.0.113.254 iptastic
```

Start the container
```
  sudo docker run -d --name elastic-0-19 \
  --net iptastic --ip 203.0.113.4 \
  -v /data2/docker/containers/ubuntu-xenial-elastic-0-19/data:/data \
  -e CLUSTER_NAME='elasticsearch.pva'  \
  -it patrickvanamstel/ubuntu-xenial-elastic-0-19  
```

Now you are able to connect to this elastic search node by 
```
http://203.0.113.4:9200/_plugin/head/
```

##References
[https://docs.docker.com/engine/migration/]

[https://blog.jessfraz.com/post/ips-for-all-the-things/]


##Commands

Cheatsheet
```
sudo docker inspect 969abc97cf47

```

When debugging a new container.
```
sudo docker run --name elastic-0-19 \
  --net iptastic --ip 203.0.113.4 \
  -v /data2/docker/containers/ubuntu-xenial-elastic-0-19/data:/data \
  -e CLUSTER_NAME='elasticsearch.pva' \  
  -it patrickvanamstel/ubuntu-xenial-elastic-0-19 /bin/bash
```
