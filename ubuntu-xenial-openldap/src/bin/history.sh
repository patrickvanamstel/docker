
 /etc/init.d/slapd start
   10  slapcat -n 1
   11  slapcat -n 0
   12  cd /tmp/
   13  ls
   14  vi change.ldiff
   15  ldapsearch -Y EXTERNAL -H ldapi:///  -b cn=config -LLL "(olcDatabase={1}mdb)" > /tmp/db.ldif
   16  vi /tmp/db.ldif 
   17  ls
   18  ldapmodify  -Y EXTERNAL -H ldapi:///   -f /tmp/change.ldiff 
   19  /etc/init.d/slapd stop
   20  ps -ef | grep slapd
   21  ls
   22  kill 26
   23  ps -ef | grep slapd
   24  cp -r /etc/ldap/* /data/conf/
   25  cd /data/conf/
   26  ls
   27  pwd
   28  ls
   29  /usr/sbin/slapd -h ldap:/// ldapi:/// -g openldap -u openldap -F /data/conf/slapd.d &
   30  /usr/sbin/slapd -h "ldap:/// ldapi:///" -g openldap -u openldap -F /data/conf/slapd.d &
   31  ps -ef | grep slapd
   32  history
