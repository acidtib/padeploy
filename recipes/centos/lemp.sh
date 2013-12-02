#!/bin/bash

echo 'Going to install the LEMP stack on your box, here we go...'
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

sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php.ini

rm -rf /etc/nginx/conf.d/default.conf
touch /etc/nginx/conf.d/default.conf
cat > /etc/nginx/conf.d/default.conf <<END
server {
    listen	 80;
    #server_name example.com;


    location / {
        root   /usr/share/nginx/html;
        index index.php  index.html index.htm;
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