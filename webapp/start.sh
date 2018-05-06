#!/bin/bash



#####
# Start uWSGI
#####
# echo "==> Starting uWSGI ..."
/usr/local/bin/uwsgi --emperor /etc/uwsgi/django-uwsgi.ini
