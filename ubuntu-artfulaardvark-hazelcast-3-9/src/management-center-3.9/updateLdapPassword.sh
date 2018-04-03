#!/bin/sh

if [ $# -gt 0 ] ; then
    echo "usage: updateLdapPassword.sh"
    exit;
fi

java -cp mancenter-3.9.war Launcher updateLdapPassword
