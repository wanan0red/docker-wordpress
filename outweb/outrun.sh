#!/bin/bash
sleep 1
/etc/init.d/ssh start
/etc/init.d/php-fpm -c /usr/local/php/lib/php.ini
nginx
/etc/init.d/mysql.server restart