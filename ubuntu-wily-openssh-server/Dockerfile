FROM patrickvanamstel/ubuntu-wily-java-8
MAINTAINER Patrick van Amstel <patrickvanamstel@gmail.com>

RUN apt-get update && apt-get upgrade

RUN apt-get install -y wget tar openssh-server openssh-client supervisor sysstat sudo openssl hostname

# Configure supervisord
ADD src/supervisord.conf /etc/supervisord.conf
RUN mkdir -p /var/log/supervisor

# Create directory for running sshd
RUN mkdir -p /var/run/sshd

#Setting the password
RUN echo 'root:Docker!' | chpasswd

#Setting the ssh server to be able to connect as root
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Deploy startup script
ADD src/start.sh /usr/local/bin/start
RUN chmod 777 /usr/local/bin/start

EXPOSE 22 8012 61621

USER root
CMD start
