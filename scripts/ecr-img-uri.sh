#! /bin/sh
set -eu

. ./.env

ecr_uri=$(./scripts/ecr-uri.sh)
version=$(./scripts/version.sh)

echo $ecr_uri/$PROJECT_NAME-$STAGE:$version
