#! /bin/sh
set -eux

PROJECT_NAME=fargoat
REGION=ca-central-1
STAGE=dev

version=$(./get-version.sh)
echo $version > version.cache

account_id=$(aws sts get-caller-identity --query Account --output text)
ecr_uri=$account_id.dkr.ecr.$REGION.amazonaws.com/$PROJECT_NAME-$STAGE:$version

docker build . -t $PROJECT_NAME:$version

#serverless deploy --stage $STAGE

aws ecr get-login-password --region ca-central-1 | \
  docker login --username AWS --password-stdin \
  $account_id.dkr.ecr.$REGION.amazonaws.com
docker tag $PROJECT_NAME:$version $ecr_uri
docker push $ecr_uri
