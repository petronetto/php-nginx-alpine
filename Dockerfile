FROM alpine:edge

MAINTAINER Juliano Petronetto <juliano@petronetto.com.br>

# Install packages
RUN apk --update add --no-cache \
        nginx \
        curl \
        supervisor \
        gd \
        freetype \
        libpng \
        libjpeg-turbo \
        freetype-dev \
        libpng-dev \
        nodejs \
        git \
        php7 \
        php7-dom \
        php7-fpm \
        php7-mbstring \
        php7-mcrypt \
        php7-opcache \
        php7-pdo \
        php7-pdo_mysql \
        php7-pdo_pgsql \
        php7-pdo_sqlite \
        php7-xml \
        php7-phar \
        php7-openssl \
        php7-json \
        php7-ctype \
        php7-session \
        php7-gd \
        php7-zlib \
    && rm -rf /var/cache/apk/*

# Creating symbolic link to php
RUN ln -s /usr/bin/php7 /usr/bin/php

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Configure Nginx
COPY config/nginx/nginx.conf /etc/nginx/nginx.conf
COPY config/nginx/default /etc/nginx/sites-enabled/default

# Configure PHP-FPM
COPY config/php/php.ini /etc/php7/php.ini
COPY config/php/www.conf /etc/php7/php-fpm.d/www.conf

# Configure supervisord
COPY config/supervisord.conf /etc/supervisord.conf

# Add application
RUN mkdir -p /var/www/src
WORKDIR /var/www/src
COPY src/ /var/www/src/

# Creating user and Group, and setting correct permissions
RUN adduser -D -u 1000 -g 'www' www \
    && chown -R www:www /var/www/src \
    && chown -R www:www /var/lib/nginx

# Start Supervisord
ADD config/start.sh /start.sh
RUN chmod 755 /start.sh

# Start Supervisord
CMD ["/start.sh"]
