FROM centos:centos5
RUN yum install -y openssh-server
RUN yum install -y passwd
RUN echo d0cker | passwd --stdin root

## https://github.com/dotcloud/docker/issues/1240#issuecomment-21807183
RUN echo "NETWORKING=yes" > /etc/sysconfig/network

## http://gaijin-nippon.blogspot.com/2013/07/audit-on-lxc-host.html
RUN sed -i -e '/pam_loginuid\.so/ d' /etc/pam.d/sshd

## Turn system logging on
RUN chkconfig --level 3 rsyslog on

## install crond
RUN yum install -y vixie-cron

EXPOSE 22

ENTRYPOINT ["/sbin/init"]
