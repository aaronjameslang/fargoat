#! /bin/sh
set -eu

set -a
. ./.env
set +a

export ACCOUNT_ID=$(./scripts/account-id.sh)
export ECR_IMG_URI=$(./scripts/ecr-img-uri.sh)

serverless $@
