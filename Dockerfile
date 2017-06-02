FROM alpine:edge

# Maintainer
MAINTAINER Connor <connor.niu@gmail.com>

# Set Timezone Environments
#ENV TIMEZONE            Asia/Shanghai
#RUN \
#	apk add --update tzdata && \
#	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
#	echo "${TIMEZONE}" > /etc/timezone && \
#	apk del tzdata


# Install packages
RUN apk --update add --no-cache \
        tzdata \
        nginx \
        curl \
        bash \
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
        php7-pdo_dblib \
        php7-pdo_pgsql \
        php7-pdo_sqlite \
        php7-tokenizer \
        php7-soap \
        php7-sockets \
        php7-redis \
        php7-xdebug \
        php7-xml \
        php7-xmlrpc \
        php7-phar \
        php7-openssl \
        php7-json \
        php7-curl \
        php7-ctype \
        php7-session \
        php7-gd \
        php7-zlib \
        php7-zip \
        php7-xsl \
    && rm -rf /var/cache/apk/*

# Configuring timezones
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" >  /etc/timezone
RUN apk del tzdata && rm -rf /var/cache/apk/*

# Creating symbolic link to php
#RUN ln -s /usr/bin/php7 /usr/bin/php

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Install phpunit, the tool that we will use for testing
RUN curl --location --output /usr/local/bin/phpunit https://phar.phpunit.de/phpunit.phar
RUN chmod +x /usr/local/bin/phpunit

# Install APIDoc
#RUN npm install -g apidoc

# Install Grunt
#RUN npm install -g grunt-cli

# Install APIDoc for Grunt
#RUN npm install grunt-apidoc --save-dev

# Configure Nginx
COPY config/nginx/nginx.conf /etc/nginx/nginx.conf
COPY config/nginx/default.conf /etc/nginx/sites-enabled/default.conf

# Configure PHP-FPM
COPY config/php/php.ini /etc/php7/php.ini
COPY config/php/www.conf /etc/php7/php-fpm.d/www.conf

# Configure supervisord
COPY config/supervisord.conf /etc/supervisord.conf

# Create application folder
RUN mkdir -p /app

# Setting the workdir
WORKDIR /app

# Coping PHP example files
COPY src/ /app/

# Set UID for www user to 1000
RUN addgroup -g 1000 -S www \
    && adduser -u 1000 -D -S -G www -h /app -g www www \
    && chown -R www:www /var/lib/nginx

# Start Supervisord
ADD config/start.sh /start.sh
RUN chmod +x /start.sh

# Expose ports
EXPOSE 9000
EXPOSE 80
EXPOSE 433

# Start Supervisord
CMD ["/start.sh"]