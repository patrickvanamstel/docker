#Ubuntu 16.04 (Xenial) with Hazelcast 3.4.8

Running a hazelcast server instance  
Java 7 is required for this version

##Build

```
sudo docker build -t patrickvanamstel/ubuntu-xenial-hazelcast-3-4-8 .
```

##Publish

```
sudo docker push patrickvanamstel/ubuntu-xenial-hazelcast-3-4-8 .
```



##Commands

Cheatsheet
```
sudo docker inspect 969abc97cf47

```


#sudo docker run --name hazelcast --net iptastic --ip 203.0.113.20  -it patrickvanamstel/ubuntu-xenial-hazelcast-3-4-8 /bin/bash


#http://203.0.113.20:18080/hazelcast-mancenter/
