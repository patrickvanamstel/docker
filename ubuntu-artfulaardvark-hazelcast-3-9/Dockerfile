FROM patrickvanamstel/ubuntu-artfulaardvark-java-8
MAINTAINER Patrick van Amstel <patrickvanamstel@gmail.com>

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y supervisor

# Copy elasticsearch src to the container
# Scripts are configured tu use /data as the data folder

ADD src/hazelcast-3.9 /opt/hazelcast-3.9
ADD src/management-center-3.9 /opt/management-center-3.9

# Configure supervisord
ADD src/etc/supervisord.conf /etc/supervisord.conf
RUN mkdir -p /var/log/supervisor

# Deploy startup script
ADD src/bin/start.sh /usr/local/bin/start
RUN chmod 777 /usr/local/bin/start
RUN chmod 777 /opt/management-center-3.9/startManCenter.sh


USER root
CMD start


