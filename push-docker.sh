#!/usr/bin/env bash
docker push drsdre/php-laravel:7.4-cli-alpine \
&& docker push drsdre/php-laravel:7.4-fpm-alpine \
&& docker push drsdre/php-laravel:7.4-fpm-nginx-alpine \
&& docker push drsdre/php-laravel:8.0-cli-alpine \
&& docker push drsdre/php-laravel:8.0-fpm-alpine \
&& docker push drsdre/php-laravel:8.0-fpm-nginx-alpine \
&& docker push drsdre/php-laravel:8.1-cli-alpine \
&& docker push drsdre/php-laravel:8.1-fpm-alpine \
&& docker push drsdre/php-laravel:8.1-fpm-nginx-alpine