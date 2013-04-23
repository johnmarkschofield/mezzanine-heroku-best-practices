#!/bin/bash

while read line; do
    eval export $line
done < mhbp_settings

source $VIRTUALENV_HOME/$VIRTUALENV_NAME/bin/activate


git status | grep "nothing to commit"
if [ $? -ne 0 ]; then
    echo "First, check in all your changes to git. Then try again."
    exit 1
fi

echo "Pushing static assets to S3"
./mhbp_collectstatic.bash

echo "Pushing code to Heroku"
git push heroku master
