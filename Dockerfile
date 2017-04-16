FROM alpine:3.5
LABEL maintainer "sshnaidm <einarum@gmail.com>"
LABEL description "Python 3, UWSGI, Nginx based on Alpine Linux"

RUN apk add --no-cache python3 bash nginx uwsgi uwsgi-python3 && \
python3 -m ensurepip && \
rm -r /usr/lib/python*/ensurepip && \
pip3 install --upgrade pip setuptools && \
rm -r /root/.cache && \
ln -s /usr/bin/python3 /usr/bin/python && \
ln -s /usr/lib/uwsgi/python3_plugin.so /usr/lib/uwsgi/python_plugin.so

ENV APP_DIR /flask
#RUN mkdir $APP_DIR && chmod 777 -R $APP_DIR
# RUN mkdir -p /etc/nginx/conf.d && \
#     chown -R nginx:nginx ${APP_DIR} && \
#   	chmod 777 /run/ -R && \
#     chmod 777 /root/ -R

VOLUME ["${APP_DIR}"]
WORKDIR ${APP_DIR}

COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d/* /etc/nginx/conf.d/
COPY app.ini /app.ini
COPY entrypoint.sh /entrypoint.sh
EXPOSE 5000 80

ENTRYPOINT ["/entrypoint.sh"]
