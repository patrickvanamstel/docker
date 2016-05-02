FROM patrickvanamstel/ubuntu-wily-java-8
MAINTAINER Patrick van Amstel <patrickvanamstel@gmail.com>

RUN apt-get update && apt-get upgrade
RUN apt-get install -y tar openssh-server openssh-client supervisor sysstat sudo openssl hostname curl 

#http://docs.datastax.com/en/opscenter/5.0/opsc/install/opscInstallDeb_t.html

RUN echo "deb http://debian.datastax.com/community stable main" | sudo tee -a /etc/apt/sources.list.d/datastax.sources.list
RUN curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add -
RUN apt-get update

RUN apt-get install -y opscenter 

# Configure supervisord
ADD src/supervisord.conf /etc/supervisord.conf
RUN mkdir -p /var/log/supervisor

ADD src/start.sh /usr/local/bin/start
RUN chmod 777  /usr/local/bin/start

#Run in foreground
RUN sed -i 's/\.\/bin\/twistd/\.\/bin\/twistd -n/' /usr/share/opscenter/bin/opscenter

# See http://www.datastax.com/documentation/opscenter/4.0/opsc/reference/opscPorts_r.html
EXPOSE 8888 61620 50031
USER root 
CMD start 
