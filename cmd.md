```
docker pull nginx
docker run  -itd  nginx
docker exec -it nginx /bin/bash
apt update  && apt -y upgrade && apt -y install wget vim rpm/stable gcc pkg-config libxml2 libxml2-dev libsqlite3-dev zlib1g-dev autoconf make net-tools procps
cd /tmp
wget https://download.oracle.com/otn_software/linux/instantclient/218000/oracle-instantclient-basic-21.8.0.0.0-1.el8.x86_64.rpm
wget https://download.oracle.com/otn_software/linux/instantclient/218000/oracle-instantclient-devel-21.8.0.0.0-1.el8.x86_64.rpm
wget https://download.oracle.com/otn_software/linux/instantclient/218000/oracle-instantclient-sqlplus-21.8.0.0.0-1.el8.x86_64.rpm
mkdir /usr/packages/
mv o* /usr/packages/
cd /usr/packages/
rpm -ivh oracle-instantclient-basic-21.8.0.0.0-1.el8.x86_64.rpm --force --nodeps
rpm -ivh oracle-instantclient-sqlplus-21.8.0.0.0-1.el8.x86_64.rpm  --force --nodeps
rpm -ivh oracle-instantclient-devel-21.8.0.0.0-1.el8.x86_64.rpm --force --nodeps
echo "/usr/lib/oracle/21/client64/lib/" >> /etc/ld.so.conf
ldconfig
cd /tmp
wget https://www.php.net/distributions/php-7.4.32.tar.gz
tar -zxvf php-7.4.32.tar.gz 
cd php-7.4.32
./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --with-pdo-mysql --with-mysqli --with-gd --with-zlib --with-mcrypt --enable-fpm
make && make install
cp -rf php.ini-development /usr/local/php/lib/php.ini
cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf
cp /usr/local/php/sbin/php-fpm /etc/init.d/php-fpm
cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf
groupadd nobody
/etc/init.d/php-fpm
cd /tmp
wget http://pecl.php.net/get/oci8-2.2.0.tgz
tar -zxvf oci8-2.2.0.tgz
cd oci8-2.2.0
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config --with-oci8=shared,instantclient,/usr/lib/oracle/21/client64/lib
make && make install
echo "extension=\"oci8.so\"" >> /usr/local/php/lib/php.ini

```

```
docker pull centos:centos7.7.1908
docker images
docker run -it centos:centos7.7.1908 bash

yum update  && yum -y upgrade && yum -y install wget vim rpm/stable gcc pkg-config SDL-devel SDL2-devel  libxml2-devel libsqlite3-dev zlib1g-dev autoconf make net-tools procps sqlite-devel
cd /tmp
wget https://download.oracle.com/otn_software/linux/instantclient/218000/oracle-instantclient-basic-21.8.0.0.0-1.el8.x86_64.rpm
wget https://download.oracle.com/otn_software/linux/instantclient/218000/oracle-instantclient-devel-21.8.0.0.0-1.el8.x86_64.rpm
wget https://download.oracle.com/otn_software/linux/instantclient/218000/oracle-instantclient-sqlplus-21.8.0.0.0-1.el8.x86_64.rpm
mkdir /usr/packages/
mv o* /usr/packages/
cd /usr/packages/
rpm -ivh oracle-instantclient-basic-21.8.0.0.0-1.el8.x86_64.rpm --force --nodeps
rpm -ivh oracle-instantclient-sqlplus-21.8.0.0.0-1.el8.x86_64.rpm  --force --nodeps
rpm -ivh oracle-instantclient-devel-21.8.0.0.0-1.el8.x86_64.rpm --force --nodeps
echo "/usr/lib/oracle/21/client64/lib/" >> /etc/ld.so.conf
ldconfig
cd /tmp
wget https://www.php.net/distributions/php-7.4.32.tar.gz
tar -zxvf php-7.4.32.tar.gz 
cd php-7.4.32
./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --with-pdo-mysql --with-mysqli --with-gd --with-zlib --with-mcrypt --enable-fpm
make && make install
cp -rf php.ini-development /usr/local/php/lib/php.ini
cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf
cp /usr/local/php/sbin/php-fpm /etc/init.d/php-fpm
cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf
groupadd nobody
/etc/init.d/php-fpm
cd /tmp
wget http://pecl.php.net/get/oci8-2.2.0.tgz
tar -zxvf oci8-2.2.0.tgz
cd oci8-2.2.0
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config --with-oci8=shared,instantclient,/usr/lib/oracle/21/client64/lib
make && make install
echo "extension=\"oci8.so\"" >> /usr/local/php/lib/php.ini
rm -rf /etc/yum.repos.d/*
wget -P /etc/yum.repos.d/ http://mirrors.aliyun.com/repo/Centos-7.repo
wget -P /etc/yum.repos.d/ http://mirrors.aliyun.com/repo/epel-7.repo
yum install httpd -y
vim /etc/httpd/conf/httpd.conf

```

![image-20221021103408952](D:\MyCtf\img\image-20221021103408952.png)

```
 AddType application/x-httpd-php .php
AddType application/x-httpd-php-source .phps
```

![image-20221021103450096](D:\MyCtf\img\image-20221021103450096.png)

```
ServerName localhost:80
```

![image-20221021104427110](D:\MyCtf\img\image-20221021104427110.png)

```
Require all granted
```



```
docker commit -a "verygood" c0285debfdfe   wanan/verygood
docker commit -a "outweb" 15d09df4d903  outweb:latest
docker commit -a "inweb" 9e22cebcc974  inweb:latest
```

```
docker run -d --privileged=true -p 80:80 wanan/sql:v1.0 /usr/sbin/init
docker exec -it 9ecebf146ae7  /bin/bash
```

```
yum install -y httpd-devel
yum install -y gdbm-devel
./configure --with-mysql=/usr --enable-track-vars --prefix=/usr/local/php --with-oci8=/opt/oracle/product/9204  --with-xml --with-config-file-path=/etc --enable-url-includes --enable-sockets --enable-discard-path --with-apxs=/usr/bin/apxs --enable-force-cgi-redirect --disable-cgi --with-gettext --with-gdbm --enable-sigchild --enable-mbstring=all --disable-mbregex

make && make install
```

```
/usr/local/php/lib/php/extensions/no-debug-non-zts-20190902/
```

```
docker run -d --privileged=true -p 80:80 c   /usr/sbin/init
docker ps
docker cp jdk-8u351-linux-x64.rpm 476a40c26873:/opt
docker cp oracle-database-ee-19c-1.0-1.x86_64.rpm 476a40c26873:/opt
docker cp oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm 476a40c26873:/opt
docker exec -it f4953ddfacbb  /bin/bash
cd /opt
rpm -ivh jdk-8u351-linux-x64.rpm
yum -y install wget
wget http://www.rpmfind.net/linux/centos/7.9.2009/os/x86_64/Packages/compat-libstdc++-33-3.2.3-72.el7.x86_64.rpm
yum -y install binutils compat-libcap1 compat-libstdc++-33 compat-libstdc++-33*.i686 elfutils-libelf-devel gcc gcc-c++ glibc*.i686 glibc glibc-devel glibc-devel*.i686 ksh libgcc*.i686 libgcc libstdc++ libstdc++*.i686 libstdc++-devel libstdc++-devel*.i686 libaio libaio*.i686 libaio-devel libaio-devel*.i686 make sysstat unixODBC unixODBC*.i686 unixODBC-devel unixODBC-devel*.i686 libXp
dd if=/dev/zero of=/home/swap bs=1024 count=1024000
mkswap /home/swap
/sbin/swapon /home/swap
echo "/home/swap swap swap default 0 0" /etc/fstab
rpm -ivh compat-libstdc++-33-3.2.3-72.el7.x86_64.rpm
yum -y localinstall oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm
rpm -ivh oracle-database-ee-19c-1.0-1.x86_64.rpm --force --nodeps
/etc/init.d/oracledb_ORCLCDB-19c configure

```

orcale

```
https://blog.csdn.net/qq_43271844/article/details/120077559
```

```
fdisk -l
```



```
docker run -itd --network mynet2 nginx
docker network connect mynet2 ba4d300f8a9a
docker network connect bridge ba4d300f8a9a
```



```
docker network create --driver bridge outctf
docker network create --driver bridge --subnet 172.25.26.0/24 --gateway 172.25.26.1 mynet2 
docker run -itd --name test1 --network mynet1  centos:centos7.7.1908
docker run -itd --name test2 --network mynet2 centos:centos7.7.1908
docker network connect mynet2 test1 
docker network connect bridge test1 
docker exec -it test1 /bin/bash
docker exec -it test2 /bin/bash

yum install -y openssh-server net-tools
ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key
ssh-keygen -t dsa -f  /etc/ssh/ssh_host_ecdsa_key

yum -y install openssh-clients

```

![image-20221021224029199](D:\MyCtf\img\image-20221021224029199.png)

```
{
    "AllowedHosts": "*",
    "ConnectionStrings": {
      "Database": "Host=db:5432;Database=gzctf;Username=postgres;Password=Fyjd0HtrL00QD555W1b6WLKbLl62cHT0",
    },
    "Logging": {
      "LogLevel": {
        "Default": "Information",
        "Microsoft": "Warning",
        "Microsoft.Hosting.Lifetime": "Information"
      }
    },
    "EmailConfig": {
      "SendMailAddress": "",
      "UserName": "",
      "Password": "",
      "Smtp": {
        "Host": "localhost",
        "Port": 587
      }
    },
    "XorKey": "Q22yg09A91YWm1GsOf9VIMiw",
    "ContainerProvider": {
      "Type": "Docker", // or "Kubernetes"
      "PublicEntry": "ctf.example.com", // or "xxx.xxx.xxx.xxx"

    },
    "DisableRateLimit": false,
    "RegistryConfig": {
      "UserName": "",
      "Password": "",
      "ServerAddress": ""
    },
    "GoogleRecaptcha": {
      "VerifyAPIAddress": "https://www.recaptcha.net/recaptcha/api/siteverify",
      "Sitekey": "",
      "Secretkey": "",
      "RecaptchaThreshold": "0.5"
    }
}


```

```
version: '3.0'
services:
  gzctf:
    image: gztime/gzctf:latest
    restart: always
    ports:
      - "80:80"
    networks:
      default:
    volumes:
      - "./data/files:/app/uploads"
      - "./appsettings.json/appsettings.json:/app/appsettings.json"
      - "./logs:/app/log"
      - "./data/keys:/root/.aspnet/DataProtection-Keys"
      # - "./k8sconfig.yaml:/app/k8sconfig.yaml:ro"
      - "/var/run/docker.sock:/var/run/docker.sock"
    depends_on:
      - db

  db:
    image: postgres:alpine
    restart: always
    environment:
      - "POSTGRES_PASSWORD=Fyjd0HtrL00QD555W1b6WLKbLl62cHT0"
    networks:
      default:
    volumes:
      - "./data/db:/var/lib/postgresql/data"

networks:
  default:
    driver: bridge
    ipam:
      config:
        - subnet: 192.168.12.0/24

```

```
update "AspNetUsers" set "Role"=3 where "UserName"='wanan';

```

```
apt -y update && apt -y upgrade && apt install -y net-tools openssh-server vim &&  /etc/init.d/ssh start
docker commit -a "outweb" 15d09df4d903  outweb:latest
docker commit -a "inweb" 9e22cebcc974  inweb:latest
```

```
vi /usr/lib/systemd/system/docker.service
ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H unix://var/run/docker.sock -H fd://  --containerd=/run/containerd/containerd.sock
systemctl daemon-reload
systemctl restart docker.service
```

```
version: '2'

services:
  public:
    restart: unless-stopped
    image: outweb:latest
    networks:
      public:
        - ipv4_address: 172.26.0.2
      private:
        - ipv4_address: 172.28.0.2

  private:
    restart: unless-stopped
    image: inweb:latest
    networks:
      private:
        - ipv4_address: 172.28.0.22

networks:
  public:
    driver: bridge
    ipam:
      driver: default
      config:
        subnet: 192.168.5.0/24
        gateway: 192.168.5.254
  private:
    driver: bridge
    ipam:
      driver: default
      config:
        subnet: 192.168.67.0/24
        gateway: 192.168.67.254
```

```
sed -i 's/deb.debian.org/mirrors.aliyun.com/' /etc/apt/sources.list  \
    && sed -i 's/security.debian.org/mirrors.aliyun.com/' /etc/apt/sources.list \
    && 
```

```
passwd wanan << EOF 
wanan 
wanan 
EOF
```

```
cd /tmp
wget https://www.php.net/distributions/php-7.4.32.tar.gz
tar -zxvf php-7.4.32.tar.gz 
cd php-7.4.32
./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --with-pdo-mysql --with-mysqli --with-gd --with-zlib --with-mcrypt --enable-fpm
make && make install
cp -rf php.ini-development /usr/local/php/lib/php.ini
cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf
cp /usr/local/php/sbin/php-fpm /etc/init.d/php-fpm
cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf
groupadd nobody
/etc/init.d/php-fpm
```



```
apt install -y libaio1 libnuma1
cd /tmp
useradd mysql -M -s /sbin/nologin
wget https://downloads.mysql.com/archives/get/p/23/file/mysql-8.0.18-linux-glibc2.12-x86_64.tar.xz
tar -xvf mysql-8.0.18-linux-glibc2.12-x86_64.tar.xz
mv mysql-8.0.18-linux-glibc2.12-x86_64 /usr/local/mysql
cd /usr/local/mysql
mkdir data
chown -R mysql:mysql /usr/local/mysql

echo "[mysqld]
bind-address=0.0.0.0
port=3306
user=mysql
basedir=/usr/local/mysql
socket=/tmp/mysql.sock
#character config
character_set_server=utf8mb4
explicit_defaults_for_timestamp=true" >/usr/local/mysql/my.cnf

./bin/mysqld  --defaults-file=/usr/local/mysql/my.cnf --initialize --user=mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data
echo "skip_grant_tables=1" >> /usr/local/mysql/my.cnf

cp -a support-files/mysql.server /etc/init.d/
chmod a+x /etc/init.d/mysql.server
/etc/init.d/mysql.server start
ln -s /lib/x86_64-linux-gnu/libtinfo.so.6 /lib/x86_64-linux-gnu/libtinfo.so.5
/usr/local/mysql/bin/mysql -uroot -Be "use mysql;update user set authentication_string='' where user='root';"

cd /tmp
rm -f /usr/share/nginx/html/*
wget https://wordpress.org/wordpress-6.0.3.tar.gz
mv wordpress/* /usr/share/nginx/html/
chmod -Rf 777 /usr/local/nginx/html
```

```
echo "skip_grant_tables=1" >> /usr/local/mysql/my.cnf
/etc/init.d/mysql.server restart
/usr/local/mysql/bin/mysql -uroot -Be "use mysql;update user set authentication_string='' where user='root';"
sed -i 's/skip_grant_tables=1//' /usr/local/mysql/my.cnf
/etc/init.d/mysql.server restart
/usr/local/mysql/bin/mysql -uroot -Be "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '123456';" --connect-expired-password
```


