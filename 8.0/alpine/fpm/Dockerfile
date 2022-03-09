FROM php:8.0-fpm-alpine

MAINTAINER Andre Schuurman <docker@drsdre.org>

LABEL Description="This image contains PHP 8.0 on alpine OS with extension needed for running Laravel applications" Vendor="Andre Schuurman" Version="8.0-fpm-alpine"

ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS="0" \
    PHP_OPCACHE_MAX_ACCELERATED_FILES="10000" \
    PHP_OPCACHE_MEMORY_CONSUMPTION="192" \
    PHP_OPCACHE_MAX_WASTED_PERCENTAGE="10"

# Install production dependencies
RUN apk add --update --no-cache \
    bash \
    curl

RUN curl -sSLf \
        -o /usr/local/bin/install-php-extensions \
        https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions && \
    chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions \
    apcu \
    bcmath \
    exif \
    gd \
    gettext \
    igbinary \
    imagick \
    intl \
    opcache \
    pcntl \
    pdo_mysql \
    pdo_pgsql \
    redis \
    sockets \
    xsl \
    yaml \
    zip

# make sockets extension load first
RUN cd /usr/local/etc/php/conf.d/ && \
    mv docker-php-ext-sockets.ini 1-docker-php-ext-sockets.ini

COPY config/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# Change memory limit
RUN echo 'memory_limit = 2G ' >> /usr/local/etc/php/php.ini

# make the entrypoint executable
RUN chmod a+x /usr/local/bin/docker-php-entrypoint

# restrict console commands execution for web scripts
RUN chmod o-rx /bin/busybox /usr/bin/curl /usr/local/bin/pecl

# Cleanup
RUN rm -rf /tmp/*  ~/.pearrc

# FPM healthcheck
RUN apk add --no-cache fcgi\
    && wget -O /usr/local/bin/php-fpm-healthcheck \
    https://raw.githubusercontent.com/renatomefi/php-fpm-healthcheck/master/php-fpm-healthcheck \
    && chmod +x /usr/local/bin/php-fpm-healthcheck

HEALTHCHECK --timeout=10s CMD php-fpm-healthcheck

USER www-data
