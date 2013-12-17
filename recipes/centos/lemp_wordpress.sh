#!/bin/bash

echo 'Going to install the LEMP stack on your box with wordpress, here we go...'
echo '------------------------'

MYSQL_PASSWORD=$(openssl rand -base64 12)

rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm

yum install -y nginx php-fpm php-cli php-mysql php-gd php-imap php-ldap php-odbc php-pear php-xml php-xmlrpc php-magickwand php-magpierss php-mbstring php-mcrypt php-mssql php-shout php-snmp php-soap php-tidy php-pecl-apc mysql mysql-server

yum --enablerepo=remi -y install php-fpm php-mysql

chkconfig --levels 235 mysqld on
/etc/init.d/mysqld start

chkconfig --levels 235 nginx on
/etc/init.d/nginx start
/etc/init.d/nginx restart

rm -rf /etc/nginx/conf.d/default.conf
touch /etc/nginx/conf.d/default.conf
cat > /etc/nginx/conf.d/default.conf <<END
server {
    listen	 80;
    #server_name example.com;

    client_max_body_size 50M;

    location / {
        root   /usr/share/nginx/html;
        index index.php  index.html index.htm;
        try_files $uri $uri/ /index.php?$args;
    }

    location = /favicon.ico {
        log_not_found off;
        access_log off;
    }

    location = /robots.txt {
        allow all;
        log_not_found off;
        access_log off;
    }

    error_page  404              /404.html;
    location = /404.html {
        root   /usr/share/nginx/html;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #
    location ~ \.php$ {
        root           /usr/share/nginx/html;
        fastcgi_pass   127.0.0.1:9000;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME   \$document_root\$fastcgi_script_name;
        include        fastcgi_params;
    }
}
END

sed -i 's/user = apache/user = nginx/g' /etc/php-fpm.d/www.conf
sed -i 's/group = apache/group = nginx/g' /etc/php-fpm.d/www.conf

chkconfig --levels 235 php-fpm on
/etc/init.d/php-fpm start
/etc/init.d/php-fpm restart

/etc/init.d/nginx restart

/usr/bin/mysqladmin -u root password $MYSQL_PASSWORD

dbuser='wuser'
dbname='wordpress'

db="create database $dbname;GRANT ALL PRIVILEGES ON $dbname.* TO $dbuser@localhost IDENTIFIED BY '$MYSQL_PASSWORD';FLUSH PRIVILEGES;"
mysql -u root -p$MYSQL_PASSWORD -e "$db"

sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php.ini
sed -i 's/max_execution_time = 30/max_execution_time = 120/g' /etc/php.ini
sed -i 's/max_upload_size = 2M/max_upload_size = 50M/g' /etc/php.ini

cd /usr/share/nginx
rm -rf html

wget http://wordpress.org/latest.tar.gz
tar -zxf latest.tar.gz
mv wordpress html
cd html

cp wp-config-sample.php wp-config.php

sed -i "s/define('DB_NAME', 'database_name_here');/define('DB_NAME', '$dbname');/g" wp-config.php
sed -i "s/define('DB_USER', 'username_here');/define('DB_USER', '$dbuser');/g" wp-config.php
sed -i "s/define('DB_PASSWORD', 'password_here');/define('DB_PASSWORD', '$MYSQL_PASSWORD');/g" wp-config.php

/etc/init.d/nginx restart
/etc/init.d/php-fpm restart

echo "##############################################"
echo "#                                            #"
echo "#                 That's it!                 #"
echo "#          LEMP has been installed!          #"
echo "#                                            #"
echo "#                                            #"
echo "#    Nginx:                                  #"
echo "#    -------------------------------------   #"
echo "#    location: /usr/share/nginx/html         #"
echo "#                                            #"
echo "#                                            #"
echo "#    MySQL:                                  #"
echo "#    -------------------------------------   #"
echo "#    username: root                          #"
echo "#    password: $MYSQL_PASSWORD              #"
echo "#                                            #"
echo "#    -------------------------------------   #"
echo "#                                            #"
echo "#    Make sure to save the MySQL password.   #"
echo "#                                            #"
echo "#                                            #"
echo "##############################################"

break