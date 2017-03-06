#!/bin/sh

java -server -Djava.net.preferIPv4Stack=true -cp ../lib/hazelcast-all-3.4.8.jar com.hazelcast.client.console.ClientConsoleApp