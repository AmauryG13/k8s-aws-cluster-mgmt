#! /bin/sh
set -e

source $(dirname "$0")/functions.sh

EXE=kops
AWS_CLI=aws

get_AWS_zones () {
    local AWS_MOD=ec2
    local slice="0"

    if [ ${HA} == true ]; then
        slice="0:3"
    fi

    local AWS_AZS=$(${AWS_CLI} ${AWS_MOD} describe-availability-zones \
        --region ${AWS_REGION} \
        --query AvailabilityZones[${slice}].ZoneName \
        --output text | \
        sed 's/\t/,/g')

    CLUSTER_ZONES="--zones ${AWS_AZS} "

    if [ ${HA} == true ]; then
        CLUSTER_ZONES+="--master-zones ${AWS_AZS}"
    fi
}

check_cli ${EXE}
load_ENV_file

get_AWS_zones

configure_HA
configure_DNS_gossip

kops create cluster ${NAME} \
    --state ${STATE_STORE} \
    ${CLUSTER_ZONES} \
    --master-size ${MASTER_SIZE} \
    --node-count 1 \
    --node-size ${NODE_SIZE} \
    --topology private \
    --networking ${NETWORK} \
    --bastion \
    --dry-run \
    --output yaml > ${BASE_DIR}/../${NAME}.yaml
