#!/bin/sh

# Tweak nginx to match the workers to cpu's
procs=$(cat /proc/cpuinfo | grep processor | wc -l)
sed -i -e "s/worker_processes 5/worker_processes $procs/" /etc/nginx/nginx.conf

# New Relic config
if [ "${NEWRELIC}" = "true" ]; then
	# Install New Relic
	mkdir /opt
	cd /opt
	wget http://download.newrelic.com/php_agent/release/newrelic-php5-${NEWRELIC_VERSION}-linux-musl.tar.gz
	gzip -dc newrelic-php5-${NEWRELIC_VERSION}-linux-musl.tar.gz | tar xf -
	./newrelic-php5-${NEWRELIC_VERSION}-linux-musl/newrelic-install install

	# Configure New Relic
	sed -i -e "s/newrelic.appname = .*/newrelic.appname = \"${NEWRELIC_APP_NAME}\"/" /etc/php7/conf.d/newrelic.ini
	sed -i -e "s/newrelic.license = .*/newrelic.license = \"${NEWRELIC_LICENSE}\"/" /etc/php7/conf.d/newrelic.ini
	sed -i -e "s/;newrelic.loglevel = .*/newrelic.loglevel = \"${NEWRELIC_LOG_LEVEL}\"/" /etc/php7/conf.d/newrelic.ini
	sed -i -e "s/;newrelic.daemon.loglevel = .*/newrelic.daemon.loglevel = \"${NEWRELIC_DAEMON_LOG_LEVEL}\"/" /etc/php7/conf.d/newrelic.ini
	sed -i -e "s/newrelic.logfile = .*/newrelic.logfile = \"\/dev\/stdout\"/" /etc/php7/conf.d/newrelic.ini
	sed -i -e "s/newrelic.daemon.logfile = .*/newrelic.daemon.logfile = \"\/dev\/stdout\"/" /etc/php7/conf.d/newrelic.ini
fi;

# Start supervisord and services
exec supervisord -c /etc/supervisord.conf
