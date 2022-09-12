aws s3api create-bucket \
    --bucket state.cluster \
    --region eu-west-3

aws s3api put-bucket-versioning \
    --bucket state.cluster \
    --versioning-configuration Status=Enabled

aws s3api create-bucket \
    --bucket state.cluster-oidc \
    --region us-east-1 \
    --acl public-read


aws s3api put-bucket-encryption \
    --bucket state.cluster \
    --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'
