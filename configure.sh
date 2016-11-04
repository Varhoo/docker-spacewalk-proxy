#!/usr/bin/bash

HOSTNAME=$( hostname )
ANSWERFILE="/root/proxyanswers.txt"
RHN_SERVER=${3:-$RHN_SERVER}
RHN_USER=${1:-$RHN_USER}
RHN_PASS=${2:-$RHN_PASS}

# registration to spacewalk
wget http://$RHN_SERVER/pub/RHN-ORG-TRUSTED-SSL-CERT -O /usr/share/rhn/RHN-ORG-TRUSTED-SSL-CERT
mkdir -p /root/ssl-build

rhnreg_ks --username=$RHN_USER --serverUrl=https://$RHN_SERVER/XMLRPC --sslCACert=/usr/share/rhn/RHN-ORG-TRUSTED-SSL-CERT --profilename=client --password=$RHN_PASS --force
rhn_check -vv

# configure rhn proxy
sed s/"<hostname>"/$HOSTNAME/g $ANSWERFILE -i
sed s/"<rhn_server>"/$RHN_SERVER/g $ANSWERFILE -i

wget https://raw.githubusercontent.com/spacewalkproject/spacewalk/master/proxy/installer/get_system_id.xslt -O  /usr/share/rhn/get_system_id.xslt
SYSTEM_ID=$( xsltproc /usr/share/rhn/get_system_id.xslt /etc/sysconfig/rhn/systemid | sed s/ID-//g )

python /root/rhnclient.py $RHN_USER $RHN_PASS $RHN_SERVER $SYSTEM_ID
configure-proxy.sh --answer-file=/root/proxyanswers.txt --force --non-interactive