#! /bin/sh
set -eu

. ./.env

version=$(./scripts/version.sh)

echo $PROJECT_NAME:$version
