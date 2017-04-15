FROM alpine:3.5
LABEL maintainer "sshnaidm <einarum@gmail.com>"
LABEL description "Python 3, UWSGI, Nginx based on Alpine Linux"

RUN apk add --no-cache python3 bash nginx uwsgi uwsgi-python3 && \
python3 -m ensurepip && \
rm -r /usr/lib/python*/ensurepip && \
pip3 install --upgrade pip setuptools && \
rm -r /root/.cache && \
ln -s /usr/bin/python3 /usr/bin/python

