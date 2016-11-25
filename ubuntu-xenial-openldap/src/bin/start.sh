#!/usr/bin/env bash
# Author Patrick van Amstel
#Date 2016 11 01

set -eu

status () {
  echo "---> ${@}" >&2
}

if [ ! -e /var/lib/ldap/docker_bootstrapped ]
then

sh -c "certtool --generate-privkey > /etc/ssl/private/cakey.pem"
certtool --generate-self-signed --load-privkey /etc/ssl/private/cakey.pem --template /etc/ssl/ca.info --outfile /etc/ssl/certs/cacert.pem
certtool --generate-privkey --bits 1024 --outfile /etc/ssl/private/ldap01_slapd_key.pem
certtool --generate-certificate --load-privkey /etc/ssl/private/ldap01_slapd_key.pem --load-ca-certificate /etc/ssl/certs/cacert.pem --load-ca-privkey /etc/ssl/private/cakey.pem --template /etc/ssl/ldap01.info --outfile /etc/ssl/certs/ldap01_slapd_cert.pem

adduser openldap ssl-cert
chgrp ssl-cert /etc/ssl/private/ldap01_slapd_key.pem
chmod g+r /etc/ssl/private/ldap01_slapd_key.pem
chmod o-r /etc/ssl/private/ldap01_slapd_key.pem


cp /etc/ssl/certs/cacert.pem /data/certificates
cp /etc/ssl/certs/ldap01_slapd_cert.pem /data/certificates
cp /etc/ssl/private/ldap01_slapd_key.pem /data/certificates

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
slapd slapd/backend string HDB
slapd slapd/purge_database boolean true
slapd slapd/move_old_database boolean true
slapd slapd/allow_ldap_v2 boolean false
slapd slapd/no_configuration boolean false
slapd slapd/dump_database select when needed
EOF

  dpkg-reconfigure -f noninteractive slapd
  touch /var/lib/ldap/docker_bootstrapped

  /usr/sbin/slapd -h "ldap:/// ldapi:///" -u openldap -g openldap -d 0 &
  sleep 5
  ldapmodify -Y EXTERNAL -H ldapi:/// -f /etc/ssl/certinfo.ldif
  kill `pidof slapd`
  /usr/sbin/slapd -h "ldap:/// ldapi:/// ldaps:///" -u openldap -g openldap -d 0
   
else

	# Nice happy flow
	# If someone messes with the certificates this will not work and will not give warnings
	if [ ! -f /etc/ssl/certs/cacert.pem ]
	then
		cp /data/certificates/cacert.pem /etc/ssl/certs/cacert.pem
	fi 
	if [ ! -f /etc/ssl/certs/ldap01_slapd_cert.pem ]
	then
		cp /data/certificates/ldap01_slapd_cert.pem /etc/ssl/certs/ldap01_slapd_cert.pem
	fi
	if [ ! -f /etc/ssl/private/ldap01_slapd_key.pem ]
	then
		cp /data/certificates/ldap01_slapd_key.pem /etc/ssl/private/ldap01_slapd_key.pem
	fi
	
	chgrp ssl-cert /etc/ssl/private/ldap01_slapd_key.pem
	chmod g+r /etc/ssl/private/ldap01_slapd_key.pem
	chmod o-r /etc/ssl/private/ldap01_slapd_key.pem
	
	/usr/sbin/slapd -h "ldap:/// ldapi:/// ldaps:///" -u openldap -g openldap -d 0
fi



# ldapsearch -Y EXTERNAL -H ldapi:///  -b cn=config -LLL "(olcDatabase={1}mdb)" > /tmp/1.ldif 
# ldapsearch -Y EXTERNAL -H ldapi:///  -b cn=config -LLL "(olcDatabase={1}mdb)" > /tmp/2.ldif
#ldapmodify  -Y EXTERNAL -H ldapi:///   -f /tmp/1.ldif


