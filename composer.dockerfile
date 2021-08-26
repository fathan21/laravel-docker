FROM composer:2

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel


# RUN apk -U upgrade && \
#     apk --update add nano && \
#     rm -rf /var/cache/apk/*

WORKDIR /var/www/html
