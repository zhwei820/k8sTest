FROM 192.168.1.5:5000/python3:v3.6

# Add code

# Install application requirements
ADD ./requirements.txt /srv/
RUN pip3 install -r /srv/requirements.txt

# Add start script
ADD ./start.sh /srv/

# Add uWSGI config
ADD ./django-uwsgi.ini /etc/uwsgi/django-uwsgi.ini

ADD ./starter /srv/starter

# Create django user, will own the Django app
RUN adduser --no-create-home --disabled-login --group --system django
RUN chown -R django:django /srv/starter



# Execute start script
CMD ["/bin/bash /srv/start.sh"]
