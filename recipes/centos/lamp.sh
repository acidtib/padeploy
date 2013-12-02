#!/bin/bash

echo 'Going to install the LAMP stack on your box, here we go...'
echo '------------------------'

MYSQL_PASSWORD=$(openssl rand -base64 12)

yum install -y httpd php php-mysql php-gd php-imap php-ldap php-mbstring php-odbc php-pear php-xml php-xmlrpc php-pecl-apc mysql mysql-server

chkconfig mysql-server on
chkconfig httpd on

/etc/init.d/mysqld restart
/etc/init.d/httpd restart

/usr/bin/mysqladmin -u root password $MYSQL_PASSWORD

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