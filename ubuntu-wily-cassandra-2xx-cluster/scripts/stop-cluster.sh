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
	stopContainer $node
}

echo "id name image"
