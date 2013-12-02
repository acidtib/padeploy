#!/bin/bash

echo 'Going to install the LAMP stack on your box with wordpress, here we go...'
echo '------------------------'

MYSQL_PASSWORD=$(openssl rand -base64 12)

yum install -y httpd php php-mysql php-gd php-imap php-ldap php-mbstring php-odbc php-pear php-xml php-xmlrpc php-pecl-apc mysql mysql-server

chkconfig mysql-server on
chkconfig httpd on

/etc/init.d/mysqld restart
/etc/init.d/httpd restart

/usr/bin/mysqladmin -u root password $MYSQL_PASSWORD

dbuser='wuser'
dbname='wordpress'

db="create database $dbname;GRANT ALL PRIVILEGES ON $dbname.* TO $dbuser@localhost IDENTIFIED BY '$MYSQL_PASSWORD';FLUSH PRIVILEGES;"
mysql -u root -p$MYSQL_PASSWORD -e "$db"

sed -i 's/max_execution_time = 30/max_execution_time = 120/g' /etc/php.ini
sed -i 's/max_upload_size = 2M/max_upload_size = 50M/g' /etc/php.ini

cd /var/www
rm -rf html

wget http://wordpress.org/latest.tar.gz
tar -zxf latest.tar.gz
mv wordpress html
cd html

cp wp-config-sample.php wp-config.php

sed -i "s/define('DB_NAME', 'database_name_here');/define('DB_NAME', '$dbname');/g" wp-config.php
sed -i "s/define('DB_USER', 'username_here');/define('DB_USER', '$dbuser');/g" wp-config.php
sed -i "s/define('DB_PASSWORD', 'password_here');/define('DB_PASSWORD', '$MYSQL_PASSWORD');/g" wp-config.php

service httpd restart

echo "##############################################"
echo "#                                            #"
echo "#                 That's it!                 #"
echo "#          LAMP has been installed!          #"
echo "#                                            #"
echo "#                                            #"
echo "#    Apache:                                 #"
echo "#    -------------------------------------   #"
echo "#    location: /var/www/html                 #"
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