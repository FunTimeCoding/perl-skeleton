FROM debian
MAINTAINER Alexander Reitzel
RUN apt-get --quiet 2 update
RUN apt-get --quiet 2 install lsb-release
ADD script/vagrant/provision.sh /root/provision.sh
RUN chmod +x /root/provision.sh
RUN /root/provision.sh
ADD . /perl-skeleton
CMD ["/perl-skeleton/bin/ps"]
