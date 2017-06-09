#!/bin/bash

apt-get update && apt-get upgrade
# Curl
apt-get install curl

# Install Apache2
apt-get install apache2 apache2-doc apache2-utils

sudo apt-get -y install libapache2-mod-php mcrypt php7.0-mysql php7.0-mcrypt php7.0-curl php7.0-json php7.0-mbstring php7.0-gd php7.0-intl php-gettext php-xdebug
sudo phpenmode curl
sudo phpenmod mcrypt

sudo a2enmod rewrite

# Enable Ubuntu Firewall and allow SSH & MySQL Ports
ufw enable
ufw allow 22
ufw allow 3306

# Install MySQL Server in a Non-Interactive mode. Default root password will be "root"
echo "mysql-server-5.6 mysql-server/root_password password root" | sudo debconf-set-selections
echo "mysql-server-5.6 mysql-server/root_password_again password root" | sudo debconf-set-selections
apt-get -y install mysql-server-5.6


# Run the MySQL Secure Installation wizard
mysql_secure_installation

sed -i 's/127\.0\.0\.1/0\.0\.0\.0/g' /etc/mysql/my.cnf
mysql -uroot -p -e 'USE mysql; UPDATE `user` SET `Host`="%" WHERE `User`="root" AND `Host`="localhost"; DELETE FROM `user` WHERE `Host` != "%" AND `User`="root"; FLUSH PRIVILEGES;'

service mysql restart

apt-get install mysql-server
apt-get install mysql-client

sudo add-apt-repository -y ppa:nijel/phpmyadmin
sudo apt-get update

echo -e "\e[93m User: root, Password: root \e[39m"
# Set non-interactive mode
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/dbconfig-install boolean true'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/app-password-confirm password root'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/admin-pass password root'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/app-pass password root'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2'﻿

sudo apt-get -y install phpmyadmin

# Clean cache
sudo apt-get clean

php -r "PHP installed correctly."
php -v

apachectl -v
mysql --version

sudo service apache2 restart