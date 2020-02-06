#!/bin/sh

if [ "$FLASK_SECRET_KEY" = "" ]; then
	export FLASK_SECRET_KEY=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
fi

if [ -e requirements-alpine.txt ]; then
	apk add --no-cache $(cat requirements-alpine.txt) 
fi

if [ -e requirements.txt ]; then
	pip3 install --upgrade -r requirements.txt
fi

if [ "$FLASK_ENV" = "development" ] || [ "$FLASK_DEBUG" = "True" ]; then
	flask run
else
	nginx && uwsgi --ini /app.ini
fi
