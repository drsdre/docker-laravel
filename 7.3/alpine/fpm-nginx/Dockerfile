FROM php:7.3-fpm-alpine

MAINTAINER Andre Schuurman <docker@drsdre.org>

LABEL Description="This image contains PHP 7.3 on alpine OS with extension needed for running Laravel applications" Vendor="Andre Schuurman" Version="7.3-fpm-alpine"

ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS="0" \
    PHP_OPCACHE_MAX_ACCELERATED_FILES="10000" \
    PHP_OPCACHE_MEMORY_CONSUMPTION="192" \
    PHP_OPCACHE_MAX_WASTED_PERCENTAGE="10"

# Install production dependencies
RUN apk add --update --no-cache \
    bash \
    curl \
    supervisor
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
RUN rm -rf /tmp/*  ~/.pearrc

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/supervisord.conf

# Make the document root a volume
VOLUME /var/www/html
WORKDIR /var/www/html

# Switch to use a non-root user from here on
USER nobody

# Expose the port nginx is reachable on
EXPOSE 8080

# Let supervisord start nginx & php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Configure a healthcheck to validate that everything is up&running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:8080/fpm-ping
