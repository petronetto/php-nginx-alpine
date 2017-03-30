Dockerized PHP
==============================================
[![](https://images.microbadger.com/badges/image/petronetto/php-nginx-alpine:stable.svg)](https://microbadger.com/images/petronetto/php-nginx-alpine:stable "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/petronetto/php-nginx-alpine:stable.svg)](https://microbadger.com/images/petronetto/php-nginx-alpine:stable "Get your own version badge on microbadger.com")

This image contains:
- PHP 7.0.16
- Nginx 1.10
- Alpine Linux (Edge)
- New Relic Agent
- NodeJS
- Git
- Composer

## Docker Setup

- [Docker for Mac](https://docs.docker.com/docker-for-mac/)
- [Docker for Linux](https://docs.docker.com/engine/installation/linux/)
- [Docker for Windows](https://docs.docker.com/docker-for-windows/)
-----

## Usage
Start the Docker containers:

```bash
docker run -p 8080:80 --name <NAME_OF_YOUR_CONTAINER> -d petronetto/php-nginx-alpine
```

## New Relic
To setup New Relic Agent you must pass the environment `NEWRELIC='true'`, `NEWRELIC_VERSION='<INSERT_CURRENT_VERSION>'` and  `NEWRELIC_LICENSE='your-license'`.
>NOTE: Ensure that `NEWRELIC_VERSION` are correct, check the release versions [here](http://download.newrelic.com/php_agent/release/)


```bash
docker run -p 8080:80 \
	--name <NAME_OF_YOUR_CONTAINER> \
	-e NEWRELIC='true' \
	-e NEWRELIC_APP_NAME='MyApp' \
	-e NEWRELIC_VERSION='7.0.0.186' \
	-e NEWRELIC_LICENSE='my-license' \
	-e NEWRELIC_LOG_LEVEL='warning' \
	-e NEWRELIC_DAEMON_LOG_LEVEL='warning' \
	-d petronetto/php-nginx-alpine
```

See the PHP info on http://localhost:8080, or the static html page on http://localhost:8080/test.html


## Add extension that you need
```
FROM petronetto/php-nginx-alpine
RUN apk --update add php7-ftp && rm -rf /var/cache/apk/*
```

#### PHP extensions included:
```
$ php -m

[PHP Modules]
Core
ctype
date
dom
fileinfo
filter
gd
hash
json
libxml
mbstring
mcrypt
newrelic
openssl
pcre
PDO
pdo_mysql
pdo_pgsql
pdo_sqlite
Phar
readline
Reflection
session
SimpleXML
SPL
standard
tokenizer
xml
xmlwriter
Zend OPcache
zlib

[Zend Modules]
Zend OPcache
```

##### Other php7 packages available in repository
```
$ apk --update search php7

php7-intl-7.0.16-r2
php7-openssl-7.0.16-r2
php7-dba-7.0.16-r2
php7-sqlite3-7.0.16-r2
php7-pear-7.0.16-r2
php7-phpdbg-7.0.16-r2
xapian-bindings-php7-1.4.3-r1
php7-litespeed-7.0.16-r2
php7-gmp-7.0.16-r2
php7-pdo_mysql-7.0.16-r2
php7-pcntl-7.0.16-r2
php7-common-7.0.16-r2
php7-xsl-7.0.16-r2
php7-fpm-7.0.16-r2
php7-mysqlnd-7.0.16-r2
php7-enchant-7.0.16-r2
php7-pspell-7.0.16-r2
php7-snmp-7.0.16-r2
php7-doc-7.0.16-r2
php7-mbstring-7.0.16-r2
php7-dev-7.0.16-r2
php7-xmlrpc-7.0.16-r2
php7-embed-7.0.16-r2
php7-xmlreader-7.0.16-r2
php7-pdo_sqlite-7.0.16-r2
php7-exif-7.0.16-r2
php7-opcache-7.0.16-r2
php7-ldap-7.0.16-r2
php7-posix-7.0.16-r2
php7-session-7.0.16-r2
php7-gd-7.0.16-r2
php7-gettext-7.0.16-r2
php7-json-7.0.16-r2
php7-xml-7.0.16-r2
php7-iconv-7.0.16-r2
php7-sysvshm-7.0.16-r2
php7-curl-7.0.16-r2
php7-shmop-7.0.16-r2
php7-odbc-7.0.16-r2
php7-phar-7.0.16-r2
php7-pdo_pgsql-7.0.16-r2
php7-imap-7.0.16-r2
php7-pdo_dblib-7.0.16-r2
php7-pgsql-7.0.16-r2
php7-pdo_odbc-7.0.16-r2
php7-xdebug-2.5.0-r1
php7-zip-7.0.16-r2
php7-apache2-7.0.16-r2
php7-cgi-7.0.16-r2
php7-ctype-7.0.16-r2
php7-mcrypt-7.0.16-r2
php7-wddx-7.0.16-r2
php7-bcmath-7.0.16-r2
php7-calendar-7.0.16-r2
php7-tidy-7.0.16-r2
php7-dom-7.0.16-r2
php7-sockets-7.0.16-r2
php7-soap-7.0.16-r2
php7-apcu-5.1.8-r0
php7-sysvmsg-7.0.16-r2
php7-zlib-7.0.16-r2
php7-ftp-7.0.16-r2
php7-sysvsem-7.0.16-r2
php7-pdo-7.0.16-r2
php7-bz2-7.0.16-r2
php7-mysqli-7.0.16-r2
```
