#!/bin/bash

set -e

while read line; do
    eval export $line
done < mhbp_settings

source $VIRTUALENV_HOME/$VIRTUALENV_NAME/bin/activate

./mhbp_collectstatic.bash
git push heroku master
