# Ubuntu 15.10 (Wily) with Cassandra 22x

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


## Build and Publish

build:
```
sudo docker build -t patrickvanamstel/ubuntu-wily-cassandra-22x .
```
publish:
```
sudo docker push patrickvanamstel/ubuntu-wily-cassandra-22x
```

# Single Cassandra node
Running Cassandra as a single node is perfectly acceptable while doing
initial development. Only when testing your code against Cassandra it is
better testing it against a cluster.

Be ware that a docker cluster is different as a production cluster. Much
of the pain comes from timing issues and network traffic. A Docker cluster
on your local machine does not have those two problems.

## Run
Some samples of running a single cassandra nome

### Running with the bash shell
Good start for debugging your Dockerfile.

```
sudo docker run  -it patrickvanamstel/ubuntu-wily-cassandra-22x /bin/bash
```
You should get a bash prompt. Starting cassandra is done by executing the start command.

The ip address of this Cassandra node can be optained by inspecting the the image.

```
sudo docker inspect ${imageid}
```

In the Datastax DevCenter you can connect to this node by entering the ip address. (Note that you must have started Cassandra by running the start command). With an ssh to this ip address you can see a running Cassandra service. (Note that the ssh server must be disabled in production environments).


### Running in background with static ip address
Good start for testing a single node and see if you can connect.

Adding a bridge on your nic.
```
sudo docker network create --subnet 203.0.113.0/24 --gateway 203.0.113.254 iptastic
```
This bridge is permanent.

Start a Cassandra node on ip address 203.0.113.2
```
sudo docker run -d --net iptastic --ip 203.0.113.2 -it patrickvanamstel/ubuntu-wily-cassandra-22x

```

### cqlsh

1. Launch a container running Cassandra called amstelnode:

```
sudo docker run --detach --name amstelnode  patrickvanamstel/ubuntu-wily-cassandra-22x
```

2. Connect to it using cqlsh

```
 sudo docker run  -it --net container:amstelnode  -it patrickvanamstel/ubuntu-wily-cassandra-22x cqlsh
```

You should see something like:
```
Connected to Test Cluster at 127.0.0.1:9042.
[cqlsh 5.0.1 | Cassandra 2.2.5 | CQL spec 3.3.1 | Native protocol v4]
Use HELP for help.
cqlsh> quit

```

If not, then try it again in a few seconds - cassandra might still be starting up.

3. Lets try some CQL

Paste the following into your cqlsh prompt to create a test keyspace, and a test table:

```
CREATE KEYSPACE test_keyspace WITH REPLICATION =
{'class': 'SimpleStrategy', 'replication_factor': 1};

USE test_keyspace;

CREATE TABLE test_table (
  id text,
  test_value text,
  PRIMARY KEY (id)
);

INSERT INTO test_table (id, test_value) VALUES ('1', 'one');
INSERT INTO test_table (id, test_value) VALUES ('2', 'two');
INSERT INTO test_table (id, test_value) VALUES ('3', 'three');

SELECT * FROM test_table;
```

If that worked, you should see:
```
id | test_value
----+------------
 3 |      three
 2 |        two
 1 |        one

(3 rows)
```

## Cassandra with external mount point

Containers are not meant to store data inside the container.
In the start up script there is an option to alter the cassandra yml
with the DATA environment variable. The variable is in the example
below /data.

````
 sudo docker run  -v /data/docker/cassandra/cluster2xx/cass1:/data -e "DATA=/data" -it patrickvanamstel/ubuntu-wily-cassandra-22x
```

# Cassandra Cluster

See the scripts
[https://github.com/patrickvanamstel/docker/tree/master/ubuntu-wily-cassandra-2xx-cluster]

## Commandline
Creating 3 nodes by hand.

```
sudo docker run --detach --name cass1  patrickvanamstel/ubuntu-wily-cassandra-22x
sudo docker run --detach --name cass2 --link cass1:seed  patrickvanamstel/ubuntu-wily-cassandra-22x start seed
sudo docker run --detach --name cass3 --link cass1:seed  patrickvanamstel/ubuntu-wily-cassandra-22x start seed
```

Lets get the status of the cluster via the nodetool.
```
sudo docker run -it --net container:cass1 patrickvanamstel/ubuntu-wily-cassandra-22x nodetool status
```

If that worked, you should see:

```
Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address        Load       Tokens       Owns    Host ID                               Rack
UN  192.168.109.2  67.67 KB   256          ?       614b7a46-141d-429d-aefb-9b5a5ad3530b  rack1
UN  192.168.109.3  110.05 KB  256          ?       0187c502-8c1f-4294-8893-dcd08cdad5f4  rack1
UN  192.168.109.4  84.56 KB   256          ?       c9821231-1a84-45bc-97b6-dd4475915957  rack1

Note: Non-system keyspaces don't have the same replication settings, effective ownership information is meaningless
```

see
[http://tonylixu.blogspot.nl/2015/04/cassandra-non-system-keyspaces-dont.html] for an explanation of the Non-system keyspaces

## Scripted



# Cassandra OpsCenter


# Datastax DevCenter


# References

[https://www.digitalocean.com/community/tutorials/how-to-install-cassandra-and-run-a-single-node-cluster-on-ubuntu-14-04]

[https://github.com/pokle/cassandra]

[https://github.com/tobert/cassandra-docker/]

# Cheatsheet
```
sudo docker run  -it patrickvanamstel/ubuntu-wily-cassandra-22x /bin/bash
```

```
sudo docker run  -p 22:22 -it patrickvanamstel/ubuntu-wily-cassandra-22x /bin/bash
```

```
sudo docker inspect 325e08664b31
```
```
sudo docker run  -v /data/docker/cassandra/cluster2xx/cass1:/data -e "DATA=/data" -it patrickvanamstel/ubuntu-wily-cassandra-22x /bin/bash
```

Deleting old containers
```
sudo docker ps -a | grep 'hours ago' | awk '{print $1}' | xargs --no-run-if-empty sudo docker rm
```
