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


kops delete cluster ${NAME} \
    --state ${STATE_STORE} \
    --yes