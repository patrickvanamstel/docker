# Ubuntu 17.04 (Zesty Zapus)  Cassandra 2.1.12

Running Cassandra.

Do not try this at home ;).
This is very bad design. I create this image because i encountered a situation
where i have to deal with this.

##Build

```
sudo docker build -t patrickvanamstel/ubuntu-zestyzapus-cassandra-2-1-12 .
```

##Publish


```
sudo docker push  patrickvanamstel/ubuntu-zestyzapus-cassandra-2-1-12 .
```

##Start the container

```
  sudo docker run -d --name elastic-0-19-cassandra-2-0-17 \
  --net iptastic --ip 203.0.113.6 \
  -v /data2/docker/containers/ubuntu-xenial-elastic-0-19-cassandra-2-0-17/data:/data \
  -e CLUSTER_NAME='elasticsearch.pva'  \
  -it patrickvanamstel/ubuntu-zestyzapus-cassandra-2-1-12
```

```
  sudo docker run --name cassandra-2-1-12 \
  --net iptastic --ip 203.0.113.6 \
  -v /data2/docker/containers/ubuntu-zestyzapus-cassandra-2-1-x-n1/data:/data \
  -it patrickvanamstel/ubuntu-zestyzapus-cassandra-2-1-12 /bin/bash
```


##References
[https://docs.docker.com/engine/migration/]

[https://blog.jessfraz.com/post/ips-for-all-the-things/]


