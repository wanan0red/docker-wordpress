FROM nginx
LABEL author="wanan"
COPY outweb/nginx.conf /etc/nginx/nginx.conf
COPY outweb/password.txt /tmp/password.txt
COPY outweb/outrun.sh /tmp/outrun.sh
COPY outweb/php-7.4.32.tar.gz /tmp/php-7.4.32.tar.gz
COPY outweb/mysql-8.0.18-linux-glibc2.12-x86_64.tar.xz /tmp/mysql-8.0.18-linux-glibc2.12-x86_64.tar.xz
COPY outweb/wordpress.tar.gz /tmp/wordpress.tar.gz

RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/' /etc/apt/sources.list  \
    && sed -i 's/security.debian.org/mirrors.aliyun.com/' /etc/apt/sources.list \
    && apt -y update  \
    && apt -y upgrade  \
    && apt install -y net-tools openssh-server vim inetutils-ping wget rpm/stable gcc pkg-config libxml2 libxml2-dev libsqlite3-dev zlib1g-dev autoconf make procps \
    && sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && cd /tmp \
    && tar -zxvf php-7.4.32.tar.gz \
    && cd php-7.4.32 \
    && ./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --with-pdo-mysql --with-mysqli --with-gd --with-zlib --with-mcrypt --enable-fpm \
    && make  \
    && make install \
    && cp -rf php.ini-development /usr/local/php/lib/php.ini \
    && cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf \
    && cp /usr/local/php/sbin/php-fpm /etc/init.d/php-fpm \
    && cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf \
    && sed -i 's/user = nobody/user = www-data;/' /usr/local/php/etc/php-fpm.d/www.conf \
    && sed -i 's/group = nobody/group = www-data;/' /usr/local/php/etc/php-fpm.d/www.conf \
    && sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 200M/' /usr/local/php/lib/php.ini \
    && sed -i 's/post_max_size = 8M/post_max_size = 20M/' /usr/local/php/lib/php.ini \
    && sed -i 's/max_execution_time = 30/max_execution_time = 300/' /usr/local/php/lib/php.ini \
    && chown -R www-data:www-data /usr/share/nginx/html \
    && echo "<?php phpinfo();?>" > /usr/share/nginx/html/index.php \
    && chmod +x /tmp/outrun.sh \
    && apt install -y libaio1 libnuma1 \
    && cd /tmp \
    && useradd mysql -M -s /sbin/nologin \
    && tar -xvf mysql-8.0.18-linux-glibc2.12-x86_64.tar.xz \
    && mv mysql-8.0.18-linux-glibc2.12-x86_64 /usr/local/mysql \
    && cd /usr/local/mysql \
    && mkdir data \
    && chown -R mysql:mysql /usr/local/mysql

RUN ["/bin/bash", "-c", "passwd root <<-EOF\nroot\nroot\nEOF"]
COPY outweb/my.cnf /usr/local/mysql/my.cnf

RUN    /usr/local/mysql/bin/mysqld  --defaults-file=/usr/local/mysql/my.cnf --initialize --user=mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data \
    && echo "skip_grant_tables=1" >> /usr/local/mysql/my.cnf \
    && cp -a /usr/local/mysql/support-files/mysql.server /etc/init.d/ \
    && chmod a+x /etc/init.d/mysql.server \
    && /etc/init.d/mysql.server start \
    && ln -s /lib/x86_64-linux-gnu/libtinfo.so.6 /lib/x86_64-linux-gnu/libtinfo.so.5 \
    && /usr/local/mysql/bin/mysql -uroot -Be "use mysql;update user set authentication_string='' where user='root';create database wordpress;" \
    && sed -i 's/skip_grant_tables=1//' /usr/local/mysql/my.cnf \
    && /etc/init.d/mysql.server restart \
    && /usr/local/mysql/bin/mysql -uroot -Be "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '123456';" --connect-expired-password \
    && cd /tmp \
    && rm -f /usr/share/nginx/html/* \
    && tar xzvf /tmp/wordpress.tar.gz \
    && mv /tmp/wordpress/* /usr/share/nginx/html/ \
    && chown -R www-data:www-data /usr/share/nginx/html \
    && chmod -Rf 777 /usr/share/nginx/html 
ENTRYPOINT /tmp/outrun.sh && tail -f /dev/null
