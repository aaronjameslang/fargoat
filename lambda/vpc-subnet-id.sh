#! /bin/sh
set -eu

. ./.env

key=SUBNET_ID_$(echo $STAGE | tr a-z A-Z)

if grep -q $key .env
then
  exit
fi

subnet_id=$(serverless info -v -c vpc-serverless.yml | grep -Po '(?<=Subnet0Id: ).*$')

echo $key=$subnet_id >> .env
