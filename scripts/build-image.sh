#! /bin/sh
set -eu

. ./.env

version=$(./scripts/version.sh --new)
lcl_img_uri=$(./scripts/lcl-img-uri.sh)
docker build . -t $lcl_img_uri
docker tag $lcl_img_uri $PROJECT_NAME:latest
