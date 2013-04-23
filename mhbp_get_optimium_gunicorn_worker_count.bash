#!/usr/bin/python

# Must be executed on Heroku, not on your local system.

import os
print (os.sysconf("SC_NPROCESSORS_ONLN") * 2) + 1
