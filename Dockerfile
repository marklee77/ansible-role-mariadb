FROM ansible/ubuntu14.04-ansible:stable
MAINTAINER Mark Stillwell <mark@stillwell.me>

ENV DEBIAN_FRONTEND noninteractive

#RUN apt-get -qy clean && \
#    rm -rf /var/lib/apt/lists/* && \
#    apt-get -qy update && \
#    apt-get -qy autoremove

COPY . /var/cache/docker/mariadb
WORKDIR /var/cache/docker/mariadb

RUN mkdir -p roles && \
    ln -snf .. roles/marklee77.mariadb && \
    ansible-playbook -i inventories/local.ini deploy.yml -e '{ \
        "mariadb_enable_remote" : true, \
        "mariadb_set_root_password" : false, \
        "dockerized_deployment" : false }' && \
    rm -rf private && \
    service mysql stop

VOLUME ["/etc/mysql", "/var/run/mysqld", "/usr/lib/mysql"]

CMD [ "/usr/sbin/mysqld", \
      "--basedir=/usr", \
      "--datadir=/var/lib/mysql", \
      "--pid-file=/var/run/mysqld/mysqld.pid", \
      "--plugin-dir=/usr/lib/mysql/plugin", \
      "--port=3306", \
      "--socket=/var/run/mysqld/mysqld.sock", \
      "--user=mysql" ]

EXPOSE 3306
