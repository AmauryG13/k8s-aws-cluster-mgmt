#! /bin/sh
set -e

source $(dirname "$0")/functions.sh

EXE=kops

configure_DNS_gossip () {
    if [ ${DNS} == "gossip" ]; then
        NAME=${NAME}.k8s.local
    fi
}

check_cli ${EXE}
load_ENV_file
configure_DNS_gossip


kops create cluster ${NAME} \
    --state ${STATE_STORE} \
    --zones "${AWS_REGION}a" \
    --topology private \
    --networking ${NETWORK} \
    --bastion \
    --node-count 3 \
    --out . \
    --target=terraform

#kops create cluster ${NAME} \
#    --state ${STATE_STORE} \
#    --zones "${AWS_REGION}a,${AWS_REGION}b,${AWS_REGION}c" \
#    --master-zones "${AWS_REGION}a,${AWS_REGION}b,${AWS_REGION}c" \
#    --topology private \
#    --networking ${NETWORK} \
#    --bastion \
#    --node-count 3 \
#    --out . \
#    --target=terraform
