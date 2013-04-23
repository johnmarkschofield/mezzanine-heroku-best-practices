#!/bin/bash

set -e

while read line; do
    eval export $line
done < mhbp_settings

source $VIRTUALENV_HOME/$VIRTUALENV_NAME/bin/activate

PWD=`pwd`
PROJECTNAME=`basename $PWD`
psql -c "create database $PROJECTNAME;"
python manage.py createdb