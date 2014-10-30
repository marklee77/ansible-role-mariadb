FROM marklee77/phusion-ansible:latest
MAINTAINER Mark Stillwell <mark@stillwell.me>

COPY . /var/cache/dockerbuild/mariadb
WORKDIR /var/cache/dockerbuild/mariadb

RUN ansible-playbook -i inventories/local.ini playbooks/install.yml
RUN mkdir -p /etc/my_init.d && \
    cp scripts/startmaradb.sh /etc/my_init.d/10-mariadb && \
    chmod 755 /etc/my_init.d/10-mariadb

VOLUME [ "/root", "/etc/mysql", "/var/run/mysqld", "/var/lib/mysql", \
         "/var/log/mysql" ]

EXPOSE 3306
