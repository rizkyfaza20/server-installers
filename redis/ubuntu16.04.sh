#!/bin/bash

# Redis Installer for Ubuntu 16.04 TLS
#
# @author  Nick Tsai <myintaer@gmail.com>
# @version 1.0.0
# @link    https://github.com/yidas/server-installers

# Password
echo "Redis: Type the password for Redis, default is no authentication followed by [ENTER]:"
read -s redisPassword

# phpRedisAdmin
installAdmin=false;
echo "PHP: Do you want to install phpRedisAdmin? [Y/n, empty as No]"
read yn
case $yn in
    [Yy]* ) installAdmin=true;;
    * ) 
esac
# phpRedisAdmin authentication
if [ $installAdmin = true ]; then
    echo "phpRedisAdmin: Type the username for phpRedisAdmin, default is no authentication followed by [ENTER]:"
    read adminUsername
    adminPassword=''

    if [ $adminUsername ]; then
        echo "phpRedisAdmin: Type the password for phpRedisAdmin, followed by [ENTER]:"
        read -s adminPassword
    fi
fi

# IPv6 Disabled
if ! grep -q "net.ipv6.conf.all.disable_ipv6 = 1" /etc/sysctl.conf; then
    sudo printf "net.ipv6.conf.all.disable_ipv6 = 1\nnet.ipv6.conf.default.disable_ipv6 = 1\nnet.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
    sudo sysctl -p
    echo "IPv6 Disabled"
fi

# APT Source using IPv4
sudo apt update

# Redis
sudo apt install redis-server -y

# Redis requirepass
if [ $redisPassword ]; then
    sed -i "/# requirepass /c\requirepass ${redisPassword}" /etc/redis/redis.conf
fi

# phpRedisAdmin
if [ $installAdmin = true ]; then

  # Nginx
  sudo apt install nginx -y

  # PHP
  sudo apt-get install php-fpm php-mysql php-cli php-mcrypt php-curl php-mbstring php-imagick php-gd php-xml php-zip -y
  sudo apt-get install php-memcached memcached -y
  sudo phpenmod mcrypt
  
  # Install admin
  # Composer
  adminPath='/var/www/html/phpredisadmin'
  curl -s http://getcomposer.org/installer | php
  php composer.phar create-project erik-dubbelboer/php-redis-admin $adminPath
  # Site setting
  configUrl='https://raw.githubusercontent.com/yidas/server-installers/master/LNMP/nginx-sites/default-php7.0-all'
  sudo wget "${configUrl}" -O /etc/nginx/sites-available/default
  sudo service nginx reload

  # Config copy
  adminConfigPath="${adminPath}/includes/config.inc.php"
  cp "${adminPath}/includes/config.sample.inc.php" $adminConfigPath

  # Redis requirepass for admin
  if [ $redisPassword ]; then
      sed -i "/'auth' => /c\'auth' => '${redisPassword}' \/\/ Warning: The password is sent in plain-text to the Redis server." $adminConfigPath
  fi

  # phpRedisAdmin HTTP authentication
  if [ $adminUsername ]; then
      sed -i "/ \/\/ Uncomment to enable HTTP authentication/c\ \/\/ Uncomment to enable HTTP authentication \n'login' => array('${adminUsername}' => array('password' => '${adminPassword}'))," $adminConfigPath
  fi
fi

