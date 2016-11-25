#!/usr/bin/env bash
# Author Patrick van Amstel
# Date 2016 11 25
#
# If the openldap database is not configured congigure the database.
# This is the initial run.
# When  the initial run is done take the configured ldap database and start it.
#
#
# The database item's that must be reused over more then 1 start are stored in the /data folder.
# This file is mapped on startup with the docker command 
#
#

set -eu

# Not the initial run
if [ -f /data/conf/ldap.conf ]
then
	/usr/sbin/slapd -h "ldap:/// ldapi:/// ldaps:///" -u openldap -g openldap -d 0 -F /data/conf/slapd.d
	exit 1 # Only a safe guard. The above command will run in the foreground
fi

# Initial run

sh -c "certtool --generate-privkey > /etc/ssl/private/cakey.pem"
certtool --generate-self-signed --load-privkey /etc/ssl/private/cakey.pem --template /etc/ssl/ca.info --outfile /etc/ssl/certs/cacert.pem
certtool --generate-privkey --bits 1024 --outfile /etc/ssl/private/ldap01_slapd_key.pem
certtool --generate-certificate --load-privkey /etc/ssl/private/ldap01_slapd_key.pem --load-ca-certificate /etc/ssl/certs/cacert.pem --load-ca-privkey /etc/ssl/private/cakey.pem --template /etc/ssl/ldap01.info --outfile /etc/ssl/certs/ldap01_slapd_cert.pem

adduser openldap ssl-cert
chgrp ssl-cert /etc/ssl/private/ldap01_slapd_key.pem
chmod g+r /etc/ssl/private/ldap01_slapd_key.pem
chmod o-r /etc/ssl/private/ldap01_slapd_key.pem

# Move outside the container with the correct owner and rights
mkdir /data/certificates/cert
cp /etc/ssl/certs/cacert.pem /data/certificates/cert
mkdir /data/certificates/private
cp /etc/ssl/certs/ldap01_slapd_cert.pem /data/certificates/private
cp /etc/ssl/private/ldap01_slapd_key.pem /data/certificates/private

chown -R openldap:openldap /data/certificates
chmod 755 /data/certificates/cert
chmod 710 /data/certificates/private
chmod 640 /data/certificates/cert/*
chmod 640 /data/certificates/private/*

set -x
LDAP_ROOTPASS=${LDAP_ROOTPASS}
LDAP_DOMAIN=${LDAP_DOMAIN}
LDAP_ORGANISATION=${LDAP_ORGANISATION}

status "configuring slapd for first run"

  cat <<EOF | debconf-set-selections
slapd slapd/internal/generated_adminpw password ${LDAP_ROOTPASS}
slapd slapd/internal/adminpw password ${LDAP_ROOTPASS}
slapd slapd/password2 password ${LDAP_ROOTPASS}
slapd slapd/password1 password ${LDAP_ROOTPASS}
slapd slapd/dump_database_destdir string /var/backups/slapd-VERSION
slapd slapd/domain string ${LDAP_DOMAIN}
slapd shared/organization string ${LDAP_ORGANISATION}
slapd slapd/backend string MDB
slapd slapd/purge_database boolean true
slapd slapd/move_old_database boolean true
slapd slapd/allow_ldap_v2 boolean false
slapd slapd/no_configuration boolean false
slapd slapd/dump_database select when needed
EOF

dpkg-reconfigure -f noninteractive slapd

/usr/sbin/slapd -h "ldap:/// ldapi:///" -u openldap -g openldap -d 0 &
sleep 5

# Set the database to somewhere else

ldapmodify  -Y EXTERNAL -H ldapi:/// -f /etc/ssl/modify-database-folder.ldif

# Stop slapd service
kill `pidof slapd`
 
# Move config folder
cp -r /etc/ldap/* /data/conf/

# Rights issues
chown -R openldap:openldap /data/conf/slapd.d

# Start slapd service
/usr/sbin/slapd -h "ldap:/// ldapi:///" -u openldap -g openldap -d 0 -F /data/conf/slapd.d &
sleep 5

# All config and database are outside the docker container now 

# Add the certificates
ldapmodify -Y EXTERNAL -H ldapi:/// -f /etc/ssl/certinfo.ldif
kill `pidof slapd`

/usr/sbin/slapd -h "ldap:/// ldapi:/// ldaps:///" -u openldap -g openldap -d 0 -F /data/conf/slapd.d 

exit 1


