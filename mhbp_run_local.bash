#!/bin/bash

set -e

while read line; do
    eval export $line
done < mhbp_settings

source $LOCAL_VIRTUALENV_HOME/$LOCAL_VIRTUALENV_NAME/bin/activate

python manage.py runserver
