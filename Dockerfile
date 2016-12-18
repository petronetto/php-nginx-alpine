FROM alpine:edge

MAINTAINER Juliano Petronetto <juliano@petronetto.com.br>

# Install packages
RUN apk --update add \
        php7 \
        php7-dom \
        php7-fpm \
        php7-json \
        php7-mbstring \
        php7-mcrypt \
        php7-opcache \
        php7-pdo \
        php7-pdo_mysql \
        php7-xml \
        php7-openssl \
        nodejs \
        git \
        ca-certificates \
        nginx \
        curl \
        supervisor \
    && rm -rf /var/cache/apk/*

# Creating symbolic link to php
RUN ln -s /usr/bin/php7 /usr/bin/php

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Configure Nginx
COPY config/nginx/nginx.conf /etc/nginx/nginx.conf
COPY config/nginx/default /etc/nginx/sites-enabled/default

# Configure PHP-FPM
COPY config/php/php.ini /etc/php7/conf.d/zzz_custom.ini
COPY config/php/www.conf /etc/php/7.0/fpm/pool.d/www.conf

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add application
RUN mkdir -p /var/www/src
WORKDIR /var/www/src
COPY src/ /var/www/src/

EXPOSE 80 443
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
