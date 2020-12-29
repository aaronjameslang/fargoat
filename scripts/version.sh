#! /bin/sh
set -eu

. ./.env

cache_file=scripts/version.cache

if test "${1-}" = --new
then
  rm -f $cache_file
fi

if test -f $cache_file
then
  cat $cache_file
  exit
fi

git_descr=$(git describe --dirty --long --tag)
timestamp=$(date +%Y-%m-%dT%H%M%S%z)

if test -z "$(git status --porcelain)"
then # clean
  version=$git_descr
else
  version=$git_descr-$timestamp
  if test $STAGE = prd
  then
    echo ERROR: Production images must be built cleanly >&2
    git status >&2
    exit 1
  fi
fi

echo $version > $cache_file
echo $version
