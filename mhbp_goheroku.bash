#!/bin/bash

git status | grep "nothing to commit"
if [ $? -ne 0 ]; then
    echo "First, check in all your changes to git. Then try again."
    exit 1
fi

echo "Pushing static assets to S3"
./mhbp_collectstatic.bash
echo

echo "Pushing code to your git repo"
git push origin master
echo

echo "Pushing configuration variables to Heroku"
while read line; do
    PREFIX=${line:0:6}
    if [ "$PREFIX" = "LOCAL_" ]; then
        echo "Local variable. Skipping $line"
        continue
    fi
    NAME=`echo $line | awk -F "=" '{print $1}'`
    VALUE=`echo $line | awk -F "=" '{print $2}'`
    HEROKU_VALUE="`heroku config:get $NAME`"
    if [ "$HEROKU_VALUE" != "$VALUE" ]; then
        echo "Setting $NAME"
        eval heroku config:set $line
    fi
done < mhbp_settings
echo

echo "Pushing code to Heroku"
heroku maintenance:on
git push heroku master
heroku maintenance:off
