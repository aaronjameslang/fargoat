#! /bin/sh
set -u

# Source like
# . install.sh

nvm use
npm install

python3.7 -m venv env
. env/bin/activate
pip install -r requirements.freeze

# Update
# pip install -r requirements.update
# pip freeze   > requirements.freeze
