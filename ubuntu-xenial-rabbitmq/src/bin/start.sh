#!/usr/bin/env bash


sed -i -e "s/LOG_BASE=\${SYS_PREFIX}\/var\/log\/rabbitmq/LOG_BASE=\/data\/log/" /usr/lib/rabbitmq/lib/rabbitmq_server-3.5.7/sbin/rabbitmq-defaults
sed -i -e "s/MNESIA_BASE=\${SYS_PREFIX}\/var\/lib\/rabbitmq\/mnesia/MNESIA_BASE=\/data\/mnesia/" /usr/lib/rabbitmq/lib/rabbitmq_server-3.5.7/sbin/rabbitmq-defaults

rabbitmq-server&

sleep 10

rabbitmqctl add_user admin admin
rabbitmqctl set_user_tags admin administrator
rabbitmqctl set_permissions -p / admin  ".*" ".*" ".*"

rabbitmq-plugins enable rabbitmq_management

wait

