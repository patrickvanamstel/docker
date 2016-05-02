#Ubuntu 15.10 (Wily) with OpsCenter installed

Ubuntu 15.10 with OpsCenter installed

Based on [https://github.com/pokle/cassandra].
This is Cassandra installation is build on the java 8 version
and Ubuntu 15.10. Ubuntu 15:10 i am more familure with.


## Build and Publish

build:
```
 sudo docker build -t patrickvanamstel/ubuntu-wily-cassandra-opscenter-50 .
```
publish:
```
sudo docker push patrickvanamstel/ubuntu-wily-cassandra-opscenter-50
```

run:
sudo docker run -it patrickvanamstel/ubuntu-wily-cassandra-opscenter-50 /bin/bash
