FROM ansible/ubuntu14.04-ansible:stable
MAINTAINER Mark Stillwell <mark@stillwell.me>

ENV DEBIAN_FRONTEND noninteractive

COPY . /var/cache/docker/mariadb
WORKDIR /var/cache/docker/mariadb
RUN mkdir -p roles && ln -snf .. roles/marklee77.mariadb 
RUN ansible-playbook -i inventories/local.ini deploy.yml -e '{ \
        "mariadb_bind_address" : 0.0.0.0, \
        "mariadb_set_root_password" : false, \
        "mariadb_dockerized_deployment" : false }' && \
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
