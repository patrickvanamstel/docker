# Ubuntu 15.10 (Wily) with Cassandra 22x clustered

Scripts for starting and stopping docker images / containers.
The configuration of the cluster is done in a properties file. This file
is read by the bash script. Personal i like yaml better, but i do not know
how to parse that in bash.

TODO:
- Exteralize the database folders.
- Clean scripts

## Scripts

cluster.properties

./create-cluster.sh

./start-cluster.sh

./stop-cluster.sh

./delete-cluster-containers.sh

./list-cluster-images.sh

## Datastax DevCenter


## OpsCenter
