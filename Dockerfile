FROM ansible/ubuntu14.04-ansible:stable
MAINTAINER Mark Stillwell <mark@stillwell.me>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qy clean && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get -qy update && \
    apt-get -qy dist-upgrade && \
    apt-get -qy autoremove

ADD . ansible-role-mariadb
RUN cd ansible-role-mariadb && \
    ansible-playbook -i inventories/local.ini -e mariadb_enable_remote=true site.yml && \
    cd .. && \
    rm -rf ansible-role-mariadb && \
    service mysql stop

VOLUME ["/etc/mysql", "/var/run/mysqld", "/usr/lib/mysql"]
EXPOSE 3306

CMD ["/usr/sbin/mysqld", "--user=mysql", "--basedir=/usr", "--port=3306", \
     "--datadir=/var/lib/mysql", \
     "--plugin-dir=/usr/lib/mysql/plugin", \
     "--pid-file=/var/run/mysqld/mysqld.pid", \
     "--socket=/var/run/mysqld/mysqld.sock" ]

