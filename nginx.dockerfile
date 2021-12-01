FROM nginx:stable-alpine

ADD ./nginx/nginx.conf /etc/nginx/
ADD ./nginx/default.conf /etc/nginx/conf.d/

RUN mkdir -p /var/www/html

RUN addgroup -g 1000 user-dev && adduser -G user-dev -g user-dev -s /bin/sh -D user-dev

RUN chown user-dev:user-dev /var/www/html


# Essentials
# RUN echo "UTC" > /etc/timezone



