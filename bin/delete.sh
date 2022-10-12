#! /bin/sh
set -e
source $(dirname "$0")/functions.sh

EXE=kops

check_cli ${EXE}
load_ENV_file

configure_HA
configure_DNS_gossip


kops delete cluster ${NAME} \
    --state ${STATE_STORE} \
    --yes