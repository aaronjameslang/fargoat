#! /bin/sh
set -eu

version=$(./get-version.sh)
echo $version > version.cache
docker build . -t fargoat:$version
