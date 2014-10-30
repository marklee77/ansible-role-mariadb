#!/bin/bash

: ${mysql_root_password:="password"}
: ${docker_host:="localhost"}

service start mariadb
ansible-playbook -i inventories/local.ini playbooks/configure.yml -e "{
    'mariadb_mysql_root_password' : '${mysql_root_password}',
    'mariadb_docker_host' : '${docker_host}' }"
