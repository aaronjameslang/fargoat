#! /bin/sh
set -eu

version=$(./scripts/version.sh --new)
lcl_img_uri=$(./scripts/lcl-img-uri.sh)
docker build . -t $lcl_img_uri
