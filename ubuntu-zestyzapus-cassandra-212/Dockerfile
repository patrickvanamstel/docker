FROM patrickvanamstel/ubuntu-zestyzapus-java-8
MAINTAINER Patrick van Amstel <patrickvanamstel@gmail.com>

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y supervisor

# Copy elasticsearch src to the container
# Scripts are configured tu use /data as the data folder

ADD src/apache-cassandra-2.1.12 /opt/apache-cassandra-2.1.12

# Configure supervisord
ADD src/etc/supervisord.conf /etc/supervisord.conf
RUN mkdir -p /var/log/supervisor

# Deploy startup script
ADD src/bin/start.sh /usr/local/bin/start
RUN chmod 777 /usr/local/bin/start

USER root
CMD start
