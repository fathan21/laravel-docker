FROM composer:2

RUN addgroup -g 1000 user-dev && adduser -G user-dev -g user-dev -s /bin/sh -D user-dev


# RUN apk -U upgrade && \
#     apk --update add nano && \
#     rm -rf /var/cache/apk/*

WORKDIR /var/www/html
