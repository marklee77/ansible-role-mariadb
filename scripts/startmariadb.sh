#!/bin/bash

: ${mysql_root_password:="password"}
: ${docker_host:="localhost"}

/usr/sbin/mysqld --bind-address=127.0.0.1 &

ansible-playbook -i inventories/local.ini provisioning/configure.yml -e "{
    \"mariadb_dockerize_context\" : \"docker\",
    \"mariadb_mysql_root_password\" : \"${mysql_root_password}\",
    \"mariadb_docker_host\" : \"${docker_host}\" }"

service mysql restart
