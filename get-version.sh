#! /bin/sh
set -eu

git_descr=$(git describe --dirty --long --tag)
timestamp=$(date +%Y-%m-%dT%H%M%S%z)

if test -z "$(git status --porcelain)"
then # clean
  echo $git_descr
else
  echo $git_descr-$timestamp
fi



