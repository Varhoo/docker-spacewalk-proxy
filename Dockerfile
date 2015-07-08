FROM fedora:22
MAINTAINER "Pavel Studenik" <pstudeni@redhat.com>

RUN rpm -Uvh http://yum.spacewalkproject.org/nightly/Fedora/22/x86_64/spacewalk-repo-2.4-3.fc22.noarch.rpm
RUN sed s/enabled=0/enabled=1/g /etc/yum.repos.d/spacewalk-nightly.repo -i && \
    sed s/enabled=1/enabled=0/g /etc/yum.repos.d/spacewalk.repo -i

RUN dnf install spacewalk-proxy-selinux spacewalk-proxy-installer \
rhn-client-tools rhn-check rhn-setup rhnsd m2crypto wget -y

ENV DOCKER_HOST unix:///tmp/docker.sock

ADD proxyanswers.txt /root/proxyanswers.txt
ADD rhnclient.py /root/rhnclient.py
ADD run.sh /root/run.sh

# it needs to registered to spacewalk
RUN chmod a+x /root/run.sh

CMD /root/run.sh
