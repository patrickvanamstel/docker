FROM patrickvanamstel/ubuntu-xenial-tomcat-8
MAINTAINER Patrick van Amstel <patrickvanamstel@gmail.com>

RUN apt-get update && apt-get -y upgrade

ADD src/lib/jcr-2.0.jar /usr/share/tomcat8/lib/

USER root
CMD tomcat.sh start

