#! /bin/sh
set -eu

. ./.env

account_id=$(./scripts/account-id.sh)

echo $account_id.dkr.ecr.$REGION.amazonaws.com
