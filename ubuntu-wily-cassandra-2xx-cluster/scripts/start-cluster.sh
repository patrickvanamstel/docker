#!/bin/bash

echo "Starting cluster"
source ./cluster-functions.sh

# Validate node
for node in $nodes
{
	validateNodeProperties $node
}

for node in $nodes
{
	startContainer $node
}
