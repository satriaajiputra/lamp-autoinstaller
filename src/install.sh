#!/bin/bash

# created at 21/07/17
# By Satmaxt Developer
# at Sukabumi, West Java, Indonesia

if [[ $USER != 'root' ]]; then
	echo "Sorry.. Need root access for launch this script."
	exit
fi

cd /etc/apt
mv sources.list sources.txt
wget -O sources.list "https://raw.githubusercontent.com/satriaajiputra/lamp-autoinstaller/master/src/sources.list"
cd

# update and install some app
apt-get update -y && apt-get upgrade -y
apt-get install pwgen apache2 zip unzip -y
apt-get install build-essential -y

# set password for mysql-server
root_password=`pwgen -s 16 1`

# set webserver
a2enmod rewrite
cd /etc/apache2/sites-available
mv 000-default.conf 000-default.bak
wget -O 000-default.conf "https://raw.githubusercontent.com/satriaajiputra/lamp-autoinstaller/master/src/vhostconfig.conf"
service apache2 restart
cd /home
ln -s /var/www/html
cd

# install screenfetch
cd /usr/bin
wget -O screenfetch "https://raw.githubusercontent.com/KittyKatt/screenFetch/master/screenfetch-dev"
chmod +x screenfetch
cd
echo "clear" >> .profile
echo "screenfetch" >> .profile

# set password to mysql
echo "mysql-server mysql-server/root_password password $root_password" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $root_password" | sudo debconf-set-selections

apt-get install mysql-server -y

# From Bert Van Vreckem <bert.vanvreckem@gmail.com>
mysql --user=root --password=$root_password <<SETSQL
  DELETE FROM mysql.user WHERE User='';
  DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
  DROP DATABASE IF EXISTS test;
  DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
  FLUSH PRIVILEGES;
SETSQL
# end mysql install

# select php
sudo add-apt-repository ppa:ondrej/php -y
apt-get update -y
apt-get install -y php7.0 libapache2-mod-php7.0 php7.0-cli php7.0-common php7.0-mbstring php7.0-gd php7.0-intl php7.0-xml php7.0-mysql php7.0-mcrypt php7.0-zip

echo "<?php phpinfo(); ?>" > /var/www/html/info.php

service apache2 restart
service mysql restart

cd /var/www/html
wget -O phpmyadmin.zip "https://files.phpmyadmin.net/phpMyAdmin/4.7.1/phpMyAdmin-4.7.1-all-languages.zip"
unzip phpmyadmin.zip
mv phpMyAdmin-4.7.1-all-languages phpMyAdmin

# install composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
cd
apt-get update
clear

# create log
echo "Script has ben installed!" | tee log.txt
echo "===============" | tee -a log.txt
echo "List installed:" | tee -a log.txt
echo "===============" | tee -a log.txt
echo "1. PHP7.0" | tee -a log.txt
echo "2. Apache2" | tee -a log.txt
echo "3. phpMyadmin" | tee -a log.txt
echo "4. MySQL Server" | tee -a log.txt
echo "5. Screenfetch" | tee -a log.txt
echo "===============" | tee -a log.txt
echo "MySQL Login:" | tee -a log.txt
echo "===============" | tee -a log.txt
echo "Username: root" | tee -a log.txt
echo "Password: $root_password" | tee -a log.txt
echo "===============" | tee -a log.txt
echo "Look at log.txt file" | tee -a log.txt