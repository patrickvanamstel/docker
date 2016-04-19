#Ubuntu 15.10 (Wily) with Cassandra 22x

Ubuntu 15.10 with Cassandra 22x installed


##Build

```
sudo docker build -t patrickvanamstel/ubuntu-wily-cassandra-22x:v1rc1 .
```

##Publish

```
sudo docker push patrickvanamstel/ubuntu-wily-cassandra-22x:v1rc1
```

##Run
```
sudo docker run  -it patrickvanamstel/ubuntu-wily-cassandra-22x:v1rc1 /bin/bash
```

##References

[https://www.digitalocean.com/community/tutorials/how-to-install-cassandra-and-run-a-single-node-cluster-on-ubuntu-14-04]

[https://github.com/pokle/cassandra]


##Commands
```
sudo docker run  -it patrickvanamstel/ubuntu-wily-cassandra-22x:v1rc1 /bin/bash
```

```
sudo docker run  -p 22:22 -it patrickvanamstel/ubuntu-wily-cassandra-22x:v1rc1 /bin/bash
```
