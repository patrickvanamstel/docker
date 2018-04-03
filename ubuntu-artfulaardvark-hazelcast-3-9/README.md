# Ubuntu 17.10 (Artful Aardvark) with Hazelcast 3.9

Running a hazelcast server instance  


## Build

```
sudo docker build -t patrickvanamstel/ubuntu-artfulaardvark-hazelcast-3-9 .
```

## Publish

```
sudo docker push patrickvanamstel/ubuntu-artfulaardvark-hazelcast-3-9 .
```


## Start image


```
sudo docker run --name hazelcast -d \
				--net iptastic --ip 203.0.113.40 \
				-it patrickvanamstel/ubuntu-artfulaardvark-hazelcast-3-9
```

Image is started on ip address 203.0.113.40.  
  
The url to the manegement center is as  

[http://203.0.113.40:18080/hazelcast-mancenter/]

The ip address is the ip-adress of the container.
The port is set in the supervisord.conf.
The application name is set there as well.

```
./startManCenter.sh 18080 hazelcast-mancenter
```

Note in the supervisord.conf is one trick. To execute 2 commands in the command option

```
command=sh -c 'cd /opt/hazelcast-3.9/bin; ./start.sh'
```

The sh -c is prependet to the actual running of the command.
Note the that before the ;  there is no space. This is required
otherwise the command fails.


## Mancenter
When you first start the man center you will have to enter a user and a password.
The user and password created you can use in the next screen to login.

You can only use the mancenter for dev clusters not larger as 2 nodes.


## Commands

Cheatsheet

```
sudo docker run --name hazelcast --net iptastic --ip 203.0.113.20  -it patrickvanamstel/ubuntu-artfulaardvark-hazelcast-3-9 /bin/bash
sudo docker run --name hazelcast -d --net iptastic --ip 203.0.113.40 -it patrickvanamstel/ubuntu-artfulaardvark-hazelcast-3-9

```

```
sudo docker inspect 969abc97cf47

```

