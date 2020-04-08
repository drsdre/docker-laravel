FROM php:{{VERSION}}-{{TYPE}}-{{OS}}

MAINTAINER Andre Schuurman <docker@drsdre.org>

LABEL Description="This image contains PHP {{VERSION}} on {{OS}} OS with extension needed for running Laravel applications" Vendor="Andre Schuurman" Version="{{VERSION}}-{{TYPE}}-{{OS}}"

ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS="0" \
    PHP_OPCACHE_MAX_ACCELERATED_FILES="10000" \
    PHP_OPCACHE_MEMORY_CONSUMPTION="192" \
    PHP_OPCACHE_MAX_WASTED_PERCENTAGE="10"

# Install production dependencies
RUN apk add --update --no-cache \
    bash \
    curl
    #g++ \
    #gcc \
    #git \
    #imagemagick \
    #icu-libs \
    #libevent \
    #libintl \
    #libxslt \
    #libzip \
    #make \
    #mysql-client \
    #nodejs \
    #nodejs-npm \
    #yarn \
    #openssh-client \
    #postgresql-libs \
    #rsync

ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/

RUN chmod uga+x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions \
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
RUN apk del -f .build-deps && \
    rm -rf event* ev* /tmp/*  ~/.pearrc