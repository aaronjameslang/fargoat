#! /bin/sh
set -eu

cache_file=scripts/account-id.cache

if test -f $cache_file
then
  cat $cache_file
  exit
fi

account_id=$(aws sts get-caller-identity --query Account --output text)

echo $account_id > $cache_file
echo $account_id
