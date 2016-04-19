#Ubuntu 15.10 (Wily) with Cassandra 22x

Ubuntu 15.10 with Cassandra 22x installed.

Based on [https://github.com/pokle/cassandra].
This is Cassandra installation is build on the java 8 version
and Ubuntu 15.10. Ubuntu 15:10 i am more familure with.

Developing the clustered Casandra docker installation it supports:

* A single Cassandra node
* A client container to run tools as cqlsh , nodetool
* A way to use Datastax DevCenter
* A multi-node cluster - running on a single Docker host
* Configuring static ip addresses
* Using external datafolders
* Monitored cluster using OpsCenter

Note:
- Development is ongoing
- It requires docker 1.10 >>


##Build and Publish

build:
```
sudo docker build -t patrickvanamstel/ubuntu-wily-cassandra-22x .
```
publish:
```
sudo docker push patrickvanamstel/ubuntu-wily-cassandra-22x
```

# Single Cassandra node
Background

##Run

```
sudo docker run  -it patrickvanamstel/ubuntu-wily-cassandra-22x /bin/bash
```






#References

[https://www.digitalocean.com/community/tutorials/how-to-install-cassandra-and-run-a-single-node-cluster-on-ubuntu-14-04]

[https://github.com/pokle/cassandra]


#Cheatsheet
```
sudo docker run  -it patrickvanamstel/ubuntu-wily-cassandra-22x:v1rc1 /bin/bash
```

```
sudo docker run  -p 22:22 -it patrickvanamstel/ubuntu-wily-cassandra-22x:v1rc1 /bin/bash
```
