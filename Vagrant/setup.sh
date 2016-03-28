#!/bin/bash

echo "Updating repository"
add-apt-repository ppa:ondrej/php5 -y
apt-get update > /dev/null

echo "Install base packages"
apt-get install curl build-essential python-software-properties

echo "Installing Git"
apt-get install git -y

echo "Installing PHP"
apt-get install php5-common php5-dev php5-cli php5-fpm -y
apt-get install php5-curl php5-gd php5-mcrypt php5-mysql -y

echo "Preparing MySQL"
apt-get install debconf-utils -y
echo "mysql-server mysql-server/root_password password " | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password " | debconf-set-selections

echo "Installing MySQL"
apt-get install mysql-client mysql-server -y
sudo sed -i "s/bind-address.*=.*/bind-address=0.0.0.0/" /etc/mysql/my.cnf
mysql -u root -e "CREATE DATABASE IF NOT EXISTS october CHARACTER SET utf8 COLLATE utf8_general_ci;"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '';"
mysql -u root -e "FLUSH PRIVILEGES;"
sudo service mysql restart

echo "Installing Nginx"
apt-get install nginx -y

echo "Configuring Nginx"
cp /var/www/Vagrant/config/nginx_vhost /etc/nginx/sites-available/nginx_vhost
ln -s /etc/nginx/sites-available/nginx_vhost /etc/nginx/sites-enabled/
rm -rf /etc/nginx/sites-available/default

echo "Install Composer"
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

service nginx restart
service php5-fpm restart
