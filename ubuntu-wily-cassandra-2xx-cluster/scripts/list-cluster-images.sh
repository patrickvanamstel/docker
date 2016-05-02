#!/bin/bash

echo "List Cluster Images"

source ./cluster-functions.sh

# Validate node
for node in $nodes
{
	validateNodeProperties $node
}

echo "id name image"
for node in $nodes
{
	echoImage $node
}

echo "Done"

