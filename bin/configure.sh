#!/usr/bin/bash

HOSTNAME=$( hostname )
ANSWERFILE="/root/proxyanswers.txt"
RHN_USER=${1:-$RHN_USER}
RHN_PASS=${2:-$RHN_PASS}
RHN_SERVER=${3:-$RHN_SERVER}

# registration to spacewalk
wget http://$RHN_SERVER/pub/RHN-ORG-TRUSTED-SSL-CERT -O /usr/share/rhn/RHN-ORG-TRUSTED-SSL-CERT
mkdir -p /root/ssl-build

# configure rhn proxy
sed s/"<hostname>"/$HOSTNAME/g $ANSWERFILE -i
sed s/"<rhn_server>"/$RHN_SERVER/g $ANSWERFILE -i

rhnreg_ks --username=$RHN_USER --password=$RHN_PASS --serverUrl=https://$RHN_SERVER/XMLRPC --sslCACert=/usr/share/rhn/RHN-ORG-TRUSTED-SSL-CERT  --force

if rhn_check -vv; then
    SYSTEM_ID=$( xsltproc /usr/share/rhn/get_system_id.xslt /etc/sysconfig/rhn/systemid | sed s/ID-//g )
    python /root/rhnclient.py $RHN_USER $RHN_PASS $RHN_SERVER $SYSTEM_ID
    configure-proxy.sh --answer-file=/root/proxyanswers.txt --force --non-interactive
fi
