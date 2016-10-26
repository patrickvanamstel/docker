#Ubuntu 16.04 (Xenial) with RabbitMq

Ubuntu 16.04 with RabbitMq Installed

Base for easy installing extra packages in derived images.

##Build

```
sudo docker build -t patrickvanamstel/ubuntu-xenial-rabbitmq .
```

##Publish

```
sudo docker push patrickvanamstel/ubuntu-xenial-rabbitmq .
```

##Start
```
sudo docker run --name rabbitmq -d --net iptastic --ip 203.0.113.11 -v /data2/docker/containers/ubuntu-xenial-rabbitmq/data:/data -it patrickvanamstel/ubuntu-xenial-rabbitmq
```

Management console runs at
http://203.0.113.11:15672/


##Cheat sheet

sudo docker run --name rabitmq --net iptastic --ip 203.0.113.11 -v /data2/docker/containers/ubuntu-xenial-rabbitmq/data:/data -it patrickvanamstel/ubuntu-xenial-rabbitmq /bin/bash

