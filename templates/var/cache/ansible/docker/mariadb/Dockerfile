FROM ubuntu:trusty
MAINTAINER Mark Stillwell <mark@stillwell.me>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qy update
RUN apt-get -qy dist-upgrade

RUN apt-get -qy install software-properties-common
RUN apt-key adv --recv-key --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
RUN apt-add-repository 'deb {{ mariadb_repository_mirror }}/repo/{{ mariadb_version }}/ubuntu trusty main'
RUN apt-get -qy update

RUN apt-get -qy install mariadb-server mariadb-client

# needed to make database reachable from outside...
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

VOLUME ["/etc/mysql", "/var/run/mysqld", "/usr/lib/mysql"]
EXPOSE 3306

CMD ["/usr/sbin/mysqld", "--user=mysql", "--basedir=/usr", "--port=3306", \
     "--datadir=/var/lib/mysql", \
     "--plugin-dir=/usr/lib/mysql/plugin", \
     "--pid-file=/var/run/mysqld/mysqld.pid", \
     "--socket=/var/run/mysqld/mysqld.sock" ]
