FROM patrickvanamstel/ubuntu-xenial-python
MAINTAINER Patrick van Amstel <patrickvanamstel@gmail.com>

RUN apt-get update && apt-get -y upgrade

RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y slapd
RUN apt-get install ldap-utils
RUN apt-get install ssl-cert
RUN apt-get install vim -y
RUN apt-get install gnutls-bin -y


# Default configuration: can be overridden at the docker command line
ENV LDAP_ROOTPASS changeit
ENV LDAP_ORGANISATION Example.com
ENV LDAP_DOMAIN example.com

# Copy files
ADD src/bin/start-configure.sh /usr/local/bin/start
RUN chmod 777 /usr/local/bin/start

ADD src/templates/ca.info /etc/ssl/ca.info 
ADD src/templates/ldap01.info /etc/ssl/ldap01.info

ADD src/ldif/certinfo.ldif /etc/ssl/certinfo.ldif
ADD src/ldif/modify-database-folder.ldif /etc/ssl/modify-database-folder.ldif


# Define working directory.
WORKDIR /data

CMD start

