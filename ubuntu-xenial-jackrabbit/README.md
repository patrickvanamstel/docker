#Ubuntu 16.04 (Xenial) with jackrabbit

Ubuntu 16.04 with JackRabbit installed on Tomcat 8 Installed

Base for easy installing extra packages in derived images.

##Build

```
sudo docker build -t patrickvanamstel/ubuntu-xenial-jackrabbit .
```

##Publish

```
sudo docker push patrickvanamstel/ubuntu-xenial-jackrabbit .
```

## TODO
- Create configurable ip
- Create configurable data
- Include jackrabbit jar in container


##Cheat sheet

sudo docker run --name tomcat-event --net iptastic --ip 203.0.113.20 -v /data2/docker/containers/ubuntu-xenial-tomcat-8-event-service-2-0/data:/data -it patrickvanamstel/ubuntu-xenial-tomcat-8 /bin/bash

sudo docker run --name tomcat --net iptastic --ip 203.0.113.20 v /data2/docker/containers/ubuntu-xenial-tomcat-8-event-service-2-0:/data -it patrickvanamstel/ubuntu-xenial-tomcat-8 /bin/bash

