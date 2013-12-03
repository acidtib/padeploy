#!/bin/bash

echo 'Going to install the LAMP stack on your box, here we go...'
echo '------------------------'

MYSQL_PASSWORD=$(openssl rand -base64 12)

echo mysql-server mysql-server/root_password password $MYSQL_PASSWORD | debconf-set-selections
echo mysql-server mysql-server/root_password_again password $MYSQL_PASSWORD | debconf-set-selections

apt-get install -y mysql-server mysql-client apache2 install php5 libapache2-mod-php5 php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-xcache

/etc/init.d/apache2 restart

echo "##############################################"
echo "#                                            #"
echo "#                 That's it!                 #"
echo "#          LAMP has been installed!          #"
echo "#                                            #"
echo "#                                            #"
echo "#    Apache:                                 #"
echo "#    -------------------------------------   #"
echo "#    location: /var/www                      #"
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