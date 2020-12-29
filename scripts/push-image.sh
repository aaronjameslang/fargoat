#! /bin/sh
set -eu

ecr_img_uri=$(./scripts/ecr-img-uri.sh)
ecr_uri=$(./scripts/ecr-uri.sh)
lcl_img_uri=$(./scripts/lcl-img-uri.sh)

aws ecr get-login-password --region ca-central-1 | \
  docker login --username AWS --password-stdin $ecr_uri
docker tag $lcl_img_uri $ecr_img_uri
docker push $ecr_img_uri
