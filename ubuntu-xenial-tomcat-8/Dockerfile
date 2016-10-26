FROM patrickvanamstel/ubuntu-xenial-java-8
MAINTAINER Patrick van Amstel <patrickvanamstel@gmail.com>

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y tomcat8

RUN rm /etc/init.d/tomcat8

ADD src/bin/tomcat.sh  /usr/local/bin/tomcat.sh
RUN chmod 777 /usr/local/bin/tomcat.sh

USER root
CMD tomcat.sh start

