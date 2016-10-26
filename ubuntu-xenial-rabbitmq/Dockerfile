FROM patrickvanamstel/ubuntu-xenial-java-8
MAINTAINER Patrick van Amstel <patrickvanamstel@gmail.com>

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y rabbitmq-server

# Deploy startup script
ADD src/bin/start.sh /usr/local/bin/start
RUN chmod 777 /usr/local/bin/start

USER root
CMD start

