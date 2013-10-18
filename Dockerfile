# TODO: find/create a better fedora image
FROM mattdm/fedora

MAINTAINER David Davis "daviddavis@redhat.com"

# yum update
#RUN yum update -y

# disable selinux
#RUN setenforce 0
#RUN sed -i s/SELINUX=enforcing/SELINUX=permissive/g /etc/selinux/config

# install the katello-repos
RUN yum install -y http://fedorapeople.org/groups/katello/releases/yum/nightly/Fedora/19/x86_64/katello-repos-latest.rpm

# install katello
RUN yum install -y katello-all

# configure katello
RUN katello-configure --no-bars

# remove ruport
RUN rpm -e --nodeps rubygem-ruport

# setup cert perms
RUN chmod -R 777 /etc/katello
RUN chmod 777 /etc/candlepin/certs/candlepin-ca.key

# relax postgres requirements
RUN sed -i '/^local*/ s/^/#/' /var/lib/pgsql/data/pg_hba.conf
RUN sed -i '/^host*/ s/^/#/' /var/lib/pgsql/data/pg_hba.conf
RUN echo "local all all              trust" >> /var/lib/pgsql/data/pg_hba.conf
RUN echo "host  all all 127.0.0.1/32 trust" >> /var/lib/pgsql/data/pg_hba.conf
RUN echo "host  all all ::1/128      trust" >> /var/lib/pgsql/data/pg_hba.conf
RUN service postgresql restart

# stop the old services
RUN systemctl stop katello-jobs.service; systemctl stop katello.service
RUN systemctl disable katello-jobs.service; systemctl disable katello.service

