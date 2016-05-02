#!/bin/bash

echo "Delete Cluster"

source ./cluster-functions.sh

# Validate node
echo "Validate properties"
for node in $nodes
{
	validateNodeProperties $node
}

for node in $nodes
{
	deleteDockerContainer $node
}





echo "Done"



