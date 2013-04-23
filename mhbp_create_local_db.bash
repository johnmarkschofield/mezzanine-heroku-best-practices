#!/bin/bash

set -e

while read line; do
    eval export $line
done < mhbp_settings_auth

while read line; do
    eval export $line
done < mhbp_settings_local

while read line; do
    eval export $line
done < mhbp_settings


source $LOCAL_VIRTUALENV_HOME/$LOCAL_VIRTUALENV_NAME/bin/activate

PWD=`pwd`
PROJECTNAME=`basename $PWD`
psql -c "create database $PROJECTNAME;"
python manage.py createdb