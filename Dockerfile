FROM marklee77/baseimage-ansible:latest
MAINTAINER Mark Stillwell <mark@stillwell.me>

COPY . /var/cache/dockerbuild/mariadb
WORKDIR /var/cache/dockerbuild/mariadb

RUN ansible-playbook -i inventories/local.ini provisioning/install.yml -e '{ \
      "mariadb_dockerize_context" : "docker", \
      "mariadb_bind_address" : "0.0.0.0", \
      "mariadb_port" : 3306 }'

RUN mkdir -p /etc/my_init.d && \
    cp scripts/startmariadb.sh /etc/my_init.d/10-mariadb && \
    chmod 0755 /etc/my_init.d/10-mariadb

VOLUME [ "/root", "/etc/mysql", "/var/run/mysqld", "/var/lib/mysql", \
         "/var/log/mysql" ]

EXPOSE 3306
