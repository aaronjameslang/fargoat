#! /bin/sh
set -eu

key=SUBNET_ID

if grep -q $key .env
then
  exit
fi

subnet_id=$(serverless info -v -c vpc-serverless.yml | grep -Po '(?<=Subnet0Id: ).*$')

echo $key=$subnet_id >> .env
