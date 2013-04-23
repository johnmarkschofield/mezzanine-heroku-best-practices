mezzanine-heroku-best-practices
===============================

This is my attempt to document (and allow you to reproduce) the best practices for deploying your Mezzanine project to Heroku.

This does not attempt to be all things to all people. For instance, a best practice is to use some third-party service to host your static files, as Heroku isn't great for hosting static files. Amazon S3 appears to be a common choice for this, but there are other good ones. This example project will not provide a menu allowing you to choose your storage back-end -- we use Amazon S3. We make similar editorial choices everywhere. If you need something else, modify what we've created here, or start from a bare Mezzanine installation.



IMPORTANT NOTE:
Do not use this repository! It is not production ready -- at this time, it's not complete and not ready for production. It's useful as a way for me to ask for help without showing proprietary code, but probably won't be useful for you yet.


Pre-Requisites
--------------
* VirtualEnvWrapper
* An account on Amazon S3
* A PostgreSQL server running on your development machine. If you're on a Mac, I highly recommend http://postgresapp.com/



Installation
------------

Initial Install:
1. Clone the repository to your system, giving it a name on your system:
  git clone git://github.com/johnmarkschofield/mezzanine-heroku-best-practices.git YOURPROJECT
2. Create a virtual environment
  cd YOURPROJECT
  mkvirtualenv YOURPROJECT -a `pwd`
3. Install required dependencies:
  pip install -r requirements.txt
4. If you have more than one account, configure this project to use the correct account:
  git config heroku.account work
5. Create a Heroku application:
  heroku create
6. Note the host name (starting with HTTPS) that "heroku create" shows you. You'll need that when you get to the "Configure MHBP" section. Use it for "HEROKU_HOST"


Amazon S3:
1. Create a bucket in the US-East or US-Standard regions (I did not setup logging.)
2. Go to the IAM service to create credentials for MHBP to login via.
3. Create a new Group of Users and give it an appropriate name.
4. Select "Custom Policy"
5. Give it an appropriate policy name and past in the following policy document (replace EXAMPLE with the name of your bucket):
{
  "Statement": [ {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::EXAMPLE",
        "arn:aws:s3:::EXAMPLE/*"
      ]
    }]
}
6. Create a new user and give it an appropriate name. Make sure "Generate an access key for each User" is checked.
7. Download the credentials and store them somewhere safe (like your password storage utility).

Configure MHBP
1. Get a randomly-generated Django SECRET_KEY, either by creating a sample Django project with "django-admin.py startproject" or by going to http://www.miniwebtool.com/django-secret-key-generator/
2. Rename mhbp_settings_sample.py to mhbp_settings.py and edit it. None of the fields are optional.
3. In settings.py, edit the ADMINS section.


Running Locally
1. First run mhbp_collectstatic.bash
2. Create a database with psql -c "create database BLAH;"
BLAH should be the name of your database, which should be the name of the directory we're in.

Pushing To Heroku
0. If it's your first time pushing to Heroku, run "heroku run python manage.py createdb"
1. ./mhbp_goheroku.bash
2. If you get an error about your key not being authorized, fix it with:
  heroku keys:add ~/.ssh/id_rsa.pub
(This may not be the path to your SSH public key; adjust to fit.) If you still get the error, I found this very helpful: http://stackoverflow.com/a/13518981/19207

You now have a Mezzanine app running on Heroku, and hosting its static files on S3.




THANKS TO
=========
http://mezzanine.jupo.org/
https://www.djangoproject.com/
http://heroku.com/

http://stackoverflow.com/questions/11569144/proper-way-to-handle-static-files-and-templates-for-django-on-heroku

