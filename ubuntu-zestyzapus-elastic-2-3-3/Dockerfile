FROM patrickvanamstel/ubuntu-zestyzapus-java-8
MAINTAINER Patrick van Amstel <patrickvanamstel@gmail.com>

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y supervisor

# Copy elasticsearch src to the container
# Scripts are configured tu use /data as the data folder

ADD src/elasticsearch-2.3.3 /opt/elasticsearch-2.3.3


# Configure supervisord
ADD src/etc/supervisord.conf /etc/supervisord.conf
RUN mkdir -p /var/log/supervisor

# Deploy startup script
ADD src/bin/start.sh /usr/local/bin/start
RUN chmod 777 /usr/local/bin/start

RUN groupadd -r elastic && useradd -r -g elastic elastic
RUN chown -R elastic:elastic /opt/elasticsearch-2.3.3
RUN chown -R elastic:elastic /usr/local/bin

USER root
CMD start


