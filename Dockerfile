# TODO: find/create a better fedora image
FROM mattdm/fedora

MAINTAINER David Davis "daviddavis@redhat.com"

# install the katello-repos
RUN yum install -y http://fedorapeople.org/groups/katello/releases/yum/nightly/Fedora/19/x86_64/katello-repos-latest.rpm

# install katello
RUN yum install -y katello-all

# configure katello
RUN katello-configure --no-bars