#!/bin/bash

: ${mysql_root_password:="password"}
: ${docker_host:="$(route -en | perl -ane 'print "$F[1]\n" if /^0.0.0.0\s/;')"}

ansible-playbook -i inventories/local.ini provisioning/configure.yml -e "{
    \"mariadb_dockerize_context\" : \"docker\",
    \"mariadb_bind_address\" : \"0.0.0.0\", \
    \"mariadb_port\" : 3306, \
    \"mariadb_mysql_root_password\" : \"${mysql_root_password}\",
    \"mariadb_docker_host\" : \"${docker_host}\" }"

