FROM ansible/ubuntu14.04-ansible:stable
MAINTAINER Mark Stillwell <mark@stillwell.me>

COPY . /var/cache/ansible/mariadb
WORKDIR /var/cache/ansible/mariadb

RUN if [ ! -f playbooks/group_vars/all.yml ]; then \
      mkdir -p playbooks/group_vars;\
      ln -s ../../defaults/main.yml playbooks/group_vars/all.yml;\
    fi
RUN ansible-playbook -i inventories/local.ini playbooks/install.yml

VOLUME [ "/root", "/etc/mysql", "/var/run/mysqld", "/var/lib/mysql", \
         "/var/log" ]

CMD [ "/usr/bin/supervisord" ]

EXPOSE 3306
