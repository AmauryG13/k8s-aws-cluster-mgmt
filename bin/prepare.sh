#! /bin/sh
set -e

source $(dirname "$0")/functions.sh

AWS_CLI="aws"

configure_AWS () {
    local AWS_MOD=configure

    ${AWS_CLI} ${AWS_MOD} import --csv ${BASE_DIR}/../${AWS_USER_CREDS}
}

create_AWS_group () {
    local AWS_MOD="iam"

    local check=$(${AWS_CLI} ${AWS_MOD} get-group --group-name ${KOPS_GROUP})

    if [ $? == 1 ]; then
        ${AWS_CLI} ${AWS_MOD} create-group --group-name ${KOPS_GROUP}
    else
        GROUP_EXISTS=true
        echo "Group ${KOPS_GROUP} already exists"
    fi
}

add_AWS_group_policy () {
    local AWS_MOD="iam"
    local AWS_ARN=(
        "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
        "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
        "arn:aws:iam::aws:policy/AmazonS3FullAccess"
        "arn:aws:iam::aws:policy/IAMFullAccess"
        "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
        "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
        "arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess"
    )

    if [ !${GROUP_EXISTS} ]; then
        for arn in ${AWS_ARN[@]}
        do
            ${AWS_CLI} ${AWS_MOD} attach-group-policy --policy-arn ${arn} --group-name ${KOPS_GROUP}
        done
    else
        echo "Group ${KOPS_GROUP} already exists : no policy added"
    fi
}

create_AWS_users () {
    local AWS_MOD=iam
    local CREDS_DIR=${BASE_DIR}/../.creds

    for user in ${KOPS_USERS[@]}
    do
        local check=$(${AWS_CLI} ${AWS_MOD} get-user --user-name ${user})

        if [ $? == 1 ]; then
            ${AWS_CLI} ${AWS_MOD} create-user --user-name ${user}
            ${AWS_CLI} ${AWS_MOD} add-user-to-group --user-name ${user} --group-name ${KOPS_GROUP}
            ${AWS_CLI} ${AWS_MOD} create-access-key --user-name ${user} > ${CREDS_DIR}/${user}.json
        else
            echo "User ${KOPS_GROUP} already exists"
        fi
    done
}

create_S3_bucket() {
    local AWS_MOD=s3api

    if (${AWS_CLI} ${AWS_MOD} list-buckets --query "Buckets[].Name" --output text) | grep -p ${S3_BUCKET_NAME}; then
        echo "Bucket ${S3_BUCKET_NAME}(-oidc) already exists"
    else
        ${AWS_CLI} ${AWS_MOD} create-bucket --bucket ${S3_BUCKET_NAME} --region ${AWS_REGION} --create-bucket-configuration LocationConstraint=${AWS_REGION}
        ${AWS_CLI} ${AWS_MOD} create-bucket --bucket ${S3_BUCKET_NAME}-oidc --region ${AWS_REGION} --acl public-read --create-bucket-configuration LocationConstraint=${AWS_REGION}

        if ${S3_BUCKET_VERSIONNING}; then
            ${AWS_CLI} ${AWS_MOD} put-bucket-versioning --bucket ${S3_BUCKET_NAME} --versioning-configuration Status=Enabled
        fi

        if ${S3_BUCKET_ENCRYPTION}; then
            ${AWS_CLI} ${AWS_MOD} put-bucket-encryption --bucket ${S3_BUCKET_NAME} --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'
        fi
    fi
}
 
check_cli ${AWS_CLI}
load_ENV_file

GROUP_EXISTS=false

create_AWS_group
add_AWS_group_policy
create_AWS_users

create_S3_bucket