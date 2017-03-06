#Ubuntu 16.10 (Xenial) with java 7

Ubuntu 16.10 with java 7 installed

Base for easy installing extra packages in derived images.

##Build

```
sudo docker build -t patrickvanamstel/ubuntu-xenial-java-7 .
```

##Publish

```
sudo docker push patrickvanamstel/ubuntu-xenial-java-7 



#sudo docker run --name java-7 --net iptastic --ip 203.0.113.20  -it patrickvanamstel/ubuntu-xenial-java-7 /bin/bash
