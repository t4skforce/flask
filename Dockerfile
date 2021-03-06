FROM alpine

ENV APP_DIR /flask
ENV FLASK_ENV production
ENV FLASK_RUN_PORT 8080
ENV FLASK_RUN_HOST 0.0.0.0

RUN apk add --no-cache nginx \
	python3 \
	python3-dev \
	py3-gevent \
	uwsgi \
	uwsgi-python3 \
	uwsgi-http \
	uwsgi-gevent3 \
	py3-pip \
	&& pip3 install --upgrade pip \
	&& pip3 install --upgrade setuptools \
	&& pip3 install flask python-dotenv \
	&& find / -type d -name __pycache__ -exec rm -r {} + \
	&& rm -rf /root/.cache /var/cache
	

ADD flask /flask
ADD nginx.conf /etc/nginx/nginx.conf
ADD app.ini /app.ini
ADD entrypoint.sh /entrypoint.sh
RUN chown -R nginx:nginx ${APP_DIR} \
	&& chmod 777 /run/ -R \
	&& chmod 777 /root/ -R
VOLUME ${APP_DIR}
WORKDIR ${APP_DIR}

EXPOSE ${FLASK_RUN_PORT}
ENTRYPOINT ["/entrypoint.sh"]
