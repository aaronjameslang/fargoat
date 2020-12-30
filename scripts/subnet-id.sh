#! /bin/sh
set -eu

cache_file=scripts/subnet-id.cache

if test -f $cache_file
then
  cat $cache_file
  exit
fi

subnet_id=$(./scripts/serverless.sh info -v | grep -Po '(?<=subnet0id: ).*$')

echo $subnet_id > $cache_file
echo $subnet_id
