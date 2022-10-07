#! /bin/sh
set -e

BASE_DIR=$(dirname "$0")

check_cli () {
    if ! type $1 > /dev/null; then
        echo "Install `${1}` cli"
        error 1
    fi
}

load_ENV_file () {
    local ENV_FILENAME='.env'
    local ENV_FILEPATH=${BASE_DIR}/../${ENV_FILENAME}

    source ${ENV_FILEPATH}
}