FROM php:7.4-fpm-alpine


WORKDIR /var/www/html


ADD ./php/www.conf /usr/local/etc/php-fpm.d/

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

RUN mkdir -p /var/www/html

RUN chown laravel:laravel /var/www/html


RUN chmod -R 765 /var/www/html/

RUN docker-php-ext-install pdo pdo_mysql 
RUN apk add --no-cache libpng libpng-dev && docker-php-ext-install gd && apk del libpng-dev


# Setup bzip2 extension
# RUN apk add --no-cache \
#     bzip2-dev \
#     && docker-php-ext-install -j$(nproc) bz2 \
#     && docker-php-ext-enable bz2 \
#     && rm -rf /tmp/*

# Setup GD extension
# RUN apk add --no-cache \
#       freetype \
#       libjpeg-turbo \
#       libpng \
#       freetype-dev \
#       libjpeg-turbo-dev \
#       libpng-dev \
#     && docker-php-ext-configure gd \
#       --with-freetype=/usr/include/ \
#       # --with-png=/usr/include/ \ # No longer necessary as of 7.4; https://github.com/docker-library/php/pull/910#issuecomment-559383597
#       --with-jpeg=/usr/include/ \
#     && docker-php-ext-install -j$(nproc) gd \
#     && docker-php-ext-enable gd \
#     && apk del --no-cache \
#       freetype-dev \
#       libjpeg-turbo-dev \
#       libpng-dev \
#     && rm -rf /tmp/*

# Install intl extension
# RUN apk add --no-cache \
#     icu-dev \
#     && docker-php-ext-install -j$(nproc) intl \
#     && docker-php-ext-enable intl \
#     && rm -rf /tmp/*

# Install mbstring extension
# RUN apk add --no-cache \
#     oniguruma-dev \
#     && docker-php-ext-install mbstring \
#     && docker-php-ext-enable mbstring \
#     && rm -rf /tmp/*


# INstall opcache, xdebug, redis, mongodb

RUN apk --no-cache add pcre-dev ${PHPIZE_DEPS} \ 
  && pecl install xdebug mongodb \
  && docker-php-ext-enable xdebug mongodb \
  && apk del pcre-dev ${PHPIZE_DEPS}\
    && docker-php-source delete \
    && rm -rf /tmp/*

# RUN apk add --no-cache --update --virtual buildDeps autoconf \
#     && pecl install xdebug radis mongodb \
#     && docker-php-ext-enable xdebug radis mongodb \
#     && apk del buildDeps


# RUN docker-php-source extract \
    # && pecl install opcache xdebug redis mongodb apcu \
    # && pecl install opcache redis mongodb \
    # && echo "xdebug.remote_enable=on\n" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    # && echo "xdebug.remote_autostart=on\n" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    # && echo "xdebug.remote_port=9000\n" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    # && echo "xdebug.remote_handler=dbgp\n" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    # && echo "xdebug.remote_connect_back=1\n" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    # && docker-php-ext-enable opcache xdebug redis mongodb apcu \
    # && docker-php-ext-enable opcache xdebug redis mongodb \
    # && docker-php-source delete \
    # && rm -rf /tmp/*





# supervisor
RUN apk add supervisor \
 && rm -rf /var/cache/apk/*

# copy file crontab ke direktori cron.d
# COPY  /var/www/html/supervisor/cron /etc/cron.d/crontab

# masuk sebagai root
# USER root

# beri akses eksekusi crontab
# RUN chmod 0644 /etc/cron.d/crontab

# # apply cron job
# RUN crontab /etc/cron.d/crontab

# # buat log file
# RUN touch /var/log/cron.log

# jalankan command cron ketika container sudah berjalan
# CMD cron && tail -f /var/log/cron.log