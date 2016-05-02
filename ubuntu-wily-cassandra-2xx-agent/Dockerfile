FROM patrickvanamstel/ubuntu-wily-cassandra-22x
MAINTAINER Patrick van Amstel <patrickvanamstel@gmail.com>

CMD apt-get install curl

CMD echo "deb http://debian.datastax.com/community stable main"  > /etc/apt/sources.list.d/datastax.community.list
CMD curl -L https://debian.datastax.com/debian/repo_key | sudo apt-key add -
   
CMD apt-get update
CMD apt-get install datastax-agent

CMD echo "stomp_interface: 203.0.113.3" > /var/lib/datastax-agent/conf/address.yaml

EXPOSE 7199 7000 7001 9160 9042
EXPOSE 22 8012 61621

USER root
CMD start
