#! /bin/sh

ENV=$1

# Cluster
NAME=k8s.cluster.amaury13.fr
DNS=amauryg13.fr
NETWORK=weave


# AWS
AWS_ZONE="eu-west-3"
STATE_STORE="s3://state.cluster.amauryg13.fr"
MASTER_SIZE="t2.micro"
NODE_SIZE="t2.micro"

kops create cluster ${NAME} \
    --state ${STATE_STORE} \
    --zones "${AWS_ZONE}a,${AWS_ZONE}b,${AWS_ZONE}c" \
    --master-zones "${AWS_ZONE}a,${AWS_ZONE}b,${AWS_ZONE}c" \
    --topology private \
    --bastion \
    --node-count 3 \
    --dry-run \
    -o yaml > ${ENV}.yaml 
