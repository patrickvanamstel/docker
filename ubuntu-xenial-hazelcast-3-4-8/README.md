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


##Start image


```
sudo docker run --name hazelcast -d \
				--net iptastic --ip 203.0.113.40 \
				-it patrickvanamstel/ubuntu-xenial-hazelcast-3-4-8
```

Image is started on ip address 203.0.113.40.  
  
The url to the manegement center is as  

[http://203.0.113.20:18080/hazelcast-mancenter/]

The ip address is the ip-adress of the container.
The port is set in the supervisord.conf.
The application name is set there as well.

```
./startManCenter.sh 18080 hazelcast-mancenter
```

Note in the supervisord.conf is one trick. To execute 2 commands in the command option

```
command=sh -c 'cd /opt/hazelcast-3.4.8/bin; ./server.sh'
```

The sh -c is prependet to the actual running of the command.
Note the that before the ;  there is no space. This is required
otherwise the command fails.


##Commands

Cheatsheet

```
sudo docker run --name hazelcast --net iptastic --ip 203.0.113.20  -it patrickvanamstel/ubuntu-xenial-hazelcast-3-4-8 /bin/bash
```

```
sudo docker inspect 969abc97cf47

```

