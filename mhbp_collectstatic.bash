#!/bin/bash

set -e

while read line; do
    eval export $line
done < mhbp_settings

source $VIRTUALENV_HOME/$VIRTUALENV_NAME/bin/activate

python manage.py collectstatic --noinput
