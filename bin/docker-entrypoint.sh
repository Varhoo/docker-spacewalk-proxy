#!/usr/bin/bash
# register.sh <username> <password> <server>

$( which rhn_check ) -vv || $( which bash ) /root/configure.sh

echo "router .."
/usr/bin/router -c /etc/jabberd/router.xml &

echo "sm .."
/usr/bin/sm -c /etc/jabberd/sm.xml &

echo "c2s .."
/usr/bin/c2s -c /etc/jabberd/c2s.xml &

echo "s2s .."
/usr/bin/s2s -c /etc/jabberd/s2s.xml &

echo "httpd .."
$( which httpd )

echo "squid .."
$( which squid ) -f /etc/squid/squid.conf -z
$( which squid ) -f /etc/squid/squid.conf -NX -d 2
