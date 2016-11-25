#Ubuntu 16.04 (Xenial) with openldap

Ubuntu 16.04 with openldap installed. 
Openldap is secured with SSL/TLS and supports the ldaps protocol on port 636


[Extending the work of https://github.com/nickstenning/docker-slapd]

Used resources:
[https://www.digitalocean.com/community/tutorials/how-to-encrypt-openldap-connections-using-starttls]
[http://mageconfig.blogspot.nl/2014/11/enable-ssl-in-openldap.html]
[https://help.ubuntu.com/lts/serverguide/openldap-server.html#openldap-tls]

Great gui can be found 
[http://directory.apache.org/studio/]

Do not hesitate to ask any questions. It has been a trip in memory lane.


##Build

```
sudo docker build -t patrickvanamstel/ubuntu-xenial-openldap .
```

##Publish

```
sudo docker push patrickvanamstel/ubuntu-xenial-openldap
```

## Installation 
Ldap is old. Ldap is like ldap and cannot be compared to other databases.
For myself it is always a struggle to get my head around it.  This is the first 
time in 10 years that i am working with a ldap database.

Installing openldap in a docker container gives some chalanges. The container itself must
be able to be discarded and restarted at will. This means the container cannot have any
configuration or state inside the container.

Openldap when installed has its own folders for the installation. Rights permissions and
owners of the folders matter. If you start slapd as root it will not work. You have
to get the permissions right, otherwise you get strange exceptions that do not say a thing.

Configuring ldap is done at startup in the startup script. 

``` 
./src/bin/start-configure.sh 
```

This script is heavaly annotated with comments. I am a user and not a sysadmin. So the obvious 
might not be that obvious to me.

The script has 2 modes:
- The initial run
- The operational run

The initial run creates the database / certs/ configuration location

The operational run takes a configured database and starts it.

( A Magic command is slapcat -n 0 )


## Configure the LDIF database


[https://www.centos.org/docs/5/html/CDS/ag/8.0/LDAP_Data_Interchange_Format-Specifying_Directory_Entries_Using_LDIF.html]

*Domain object*
First entry in the database
```
dn: dc=example,dc=com
objectclass: top
objectclass: domain
dc: example
description: Fictional example company
```

*Add a group of ou: people*
```
dn: ou=people, dc=example,dc=com
objectclass: top
objectclass: organizationalUnit
ou: people
description: Fictional example organizational unit
```

*Add a person*

```
dn: uid=patrick,ou=people,dc=example,dc=com
objectclass: top
objectclass: person
objectclass: organizationalPerson
objectclass: inetOrgPerson
cn: Patrick van Amstel
sn: Patrick
givenname: van Amstel
uid: patrick
ou: people
description: Architect
telephonenumber: 0621178970
userpassword: {SSHA}dkfljlk34r2kljdsfk9
```

*Add a group of mailservice-docker-admin*

```
dn: cn=mailservice-docker-admin,ou=group,dc=example,dc=com
objectClass: groupOfNames
objectClass: top
cn: mailservice-docker-admin
member: uid=patrick,ou=people,dc=example,dc=com
```


## Java
If there is a need for some java code just ask.
I have to format and add it here.



## Cheatsheet
docker run --net iptastic --ip 203.0.113.14 -v /data2/docker/containers/ubuntu-xenial-openldap/data:/data -it patrickvanamstel/ubuntu-xenial-openldap  /bin/bash



