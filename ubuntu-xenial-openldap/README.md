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
configuration inside the container.

Openldap when installed has its own folders for the installation. Rights permissions and
owners of the folders matter. If you start slapd as root it will not work. You have
to get the permissions right. Otherwise you get strange exceptions that do not say a thing.

Configuring ldap is done at startup in the startup script. I have not figured out yet
how to do this in the Docker command structure.


The -F flag tells openldap where to find's it configuration database. This database is 
a ldap database as well.

Magic commands are 
slapcat -n 0


Change the default directory location is done by an ldiff file 

```
dn: olcDatabase={1}mdb,cn=config
replace: olcDbDirectory
olcDbDirectory: /data/ldap/db
```

Note the dn should match the dn of the database you want to change. slapcat -n 0 (0 .. xxx)
gives you information about the installed ldap

The 

```
ldapsearch -Y EXTERNAL -H ldapi:///  -b cn=config -LLL "(olcDatabase={1}mdb)" > /tmp/db.ldif
```

Exports the configuration of my default database.

Execute the update on the databse
```
ldapmodify  -Y EXTERNAL -H ldapi:///   -f /tmp/1.ldif
```


Finally the rights on the certificates and the certificates folders.
The rights and owner must be very strict. See the startup script for the
correct right and owner to be used. In a container i cannot see why this is.

But hey it works, so i do not complain. Needles to say that this is a selfsigned
cert and will not be recognized by any client without some manual approving this cert.

#Ldif database

[https://www.centos.org/docs/5/html/CDS/ag/8.0/LDAP_Data_Interchange_Format-Specifying_Directory_Entries_Using_LDIF.html]

*Domain object*
First entry ub the database
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


[http://serverfault.com/questions/275813/ldap-how-to-add-a-person-to-an-existing-group]
*Add a person to a group*
-- TODO
dn: ou=groups,dc=example,dc=com
changetype: modify
add: memberUid
memberUid: fred






## Cheatsheet
sudo docker run  --net iptastic --ip 203.0.113.14 -v /data2/docker/containers/ubuntu-xenial-openldap/data:/data -it patrickvanamstel/ubuntu-xenial-openldap  /bin/bash
sudo docker run -v /data/ldap:/var/lib/ldap --name openldap --net iptastic --ip 203.0.113.13 -e LDAP_DOMAIN=anachron.com -e LDAP_ORGANISATION="Anachron" -e LDAP_ROOTPASS=1234Abcd!    -it nickstenning/slapd /bin/bash

docker run  --net iptastic --ip 203.0.113.14 -v /data2/docker/containers/ubuntu-xenial-openldap/data:/data -it patrickvanamstel/ubuntu-xenial-openldap  /bin/bash

docker run --net iptastic --ip 203.0.113.14 -v /data2/docker/containers/ubuntu-xenial-openldap/data:/data -it patrickvanamstel/ubuntu-xenial-openldap  /bin/bash
