#!/bin/bash

echo "Starting cluster"
source ./cluster-functions.sh

# Validate node
for node in $nodes
{
	validateNodeProperties $node
	foldersAreInPlace $node
	dockerCanBeStarted $node
}

validateNodeProperties ops
foldersAreInPlace ops
dockerCanBeStarted ops

echo "Environment check completed"

instance=0
# Seed image

for node in $nodes
{
	nodename=${node}_name

	if [ $instance -eq 0 ];
	then
		SEED=${!nodename}
		startDockerImage $node "seed" $instance
	fi
	if [ $instance -ne 0 ];
	then
		startDockerImage $node "slave" $instance
	fi
	
	instance=`expr $instance + 1`
}

startDockerImage ops "ops" $instance


echo "Cluster started"


