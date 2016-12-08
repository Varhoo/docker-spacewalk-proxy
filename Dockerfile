FROM fedora:24
MAINTAINER "Pavel Studenik" <pstudeni@redhat.com>

RUN URL_SW=http://yum.spacewalkproject.org/nightly/Fedora/24/x86_64/ && \
rpm -Uvh $URL_SW/$( curl --silent $URL_SW | grep spacewalk-repo-[0-9] |  grep -Po '(?<=href=")[^"]*' )
RUN sed s/enabled=0/enabled=1/g /etc/yum.repos.d/spacewalk-nightly.repo -i && \
    sed s/enabled=1/enabled=0/g /etc/yum.repos.d/spacewalk.repo -i

RUN dnf install spacewalk-proxy-selinux spacewalk-proxy-installer \
rhn-client-tools rhn-check rhn-setup rhnsd rhnsd hwdata python3-dbus m2crypto wget which -y && \
dnf clean all

ENV DOCKER_HOST unix:///tmp/docker.sock

ADD proxyanswers.txt /root/proxyanswers.txt
ADD rhnclient.py /root/rhnclient.py
ADD configure.sh /root/configure.sh
ADD run.sh /root/run.sh

# it needs to registered to spacewalk
RUN chmod a+x /root/run.sh

EXPOSE 80 443 5222 5269 5280

CMD /root/run.sh
