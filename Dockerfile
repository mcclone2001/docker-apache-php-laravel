FROM ubuntu:18.04
RUN apt-get update
RUN apt-get install systemd --yes
RUN apt-get install apache2 --yes
RUN apt-get install git --yes
RUN apt-get install curl --yes
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
RUN apt-get install php7.2 libapache2-mod-php7.2 php7.2-mbstring php7.2-xmlrpc php7.2-soap php7.2-gd php7.2-xml php7.2-cli php7.2-zip --yes
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
WORKDIR /var/www/html
RUN composer create-project laravel/laravel MyProject --prefer-dist
RUN chown -R www-data:www-data /var/www/html/MyProject/
RUN chmod -R 755 /var/www/html/MyProject/
# https://websiteforstudents.com/install-laravel-php-framework-on-ubuntu-16-04-17-10-18-04-with-apache2-and-php-7-2-support/