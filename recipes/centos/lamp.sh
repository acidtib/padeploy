#!/bin/bash

echo 'Going to install the LAMP stack on your box, here we go...'
echo '------------------------'

read -p "MySQL Password: " mysqlPassword
read -p "Retype password: " mysqlPasswordRetype

yum install -y httpd php php-mysql php-gd php-imap php-ldap php-mbstring php-odbc php-pear php-xml php-xmlrpc php-pecl-apc mysql mysql-server

chkconfig --levels 235 mysqld on
/etc/init.d/mysqld start

chkconfig --levels 235 httpd on
/etc/init.d/httpd start
/etc/init.d/httpd restart

while [[ "$mysqlPassword" = "" && "$mysqlPassword" != "$mysqlPasswordRetype" ]]; do
  echo -n "Please enter the desired mysql root password: "
  stty -echo
  read -r mysqlPassword
  echo
  echo -n "Retype password: "
  read -r mysqlPasswordRetype
  stty echo
  echo
  if [ "$mysqlPassword" != "$mysqlPasswordRetype" ]; then
    echo "Passwords do not match!"
  fi
done

/usr/bin/mysqladmin -u root password $mysqlPassword

echo "###############################################"
echo "#                                             #"
echo "#                 That's it!                  #"
echo "#          LAMP has been installed!           #"
echo "#                                             #"
echo "#                                             #"
echo "#    Apache:                                  #"
echo "#    -------------------------------------    #"
echo "#    location: /var/www/html                  #"
echo "#                                             #"
echo "#                                             #"
echo "#    MySQL:                                   #"
echo "#    -------------------------------------    #"
echo "#    username: root                           #"
echo "#    password: $mysqlPassword                 #"
echo "#                                             #"
echo "#    -------------------------------------    #"
echo "#                                             #"
echo "#    Make sure to save the MySQL password.    #"
echo "#                                             #"
echo "#                                             #"
echo "###############################################"

break