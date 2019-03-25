FROM ubuntu:18.04
RUN apt-get update --yes 
RUN apt-get install apache2 --yes
RUN apt-get install git --yes
RUN apt-get install curl --yes
RUN systemctl stop apache2.service
RUN systemctl start apache2.service
RUN systemctl enable apache2.service
RUN apt-get install php libapache2-mod-php php-common php-mbstring php-xmlrpc php-soap php-gd php-xml php-mysql php-cli php-mcrypt php-zip --yes
RUN curl -sS https://getcomposer.org/installer
RUN php -- --install-dir=/usr/local/bin --filename=composer
RUN cd /var/www/html
RUN composer create-project laravel/laravel MyProject --prefer-dist
RUN chown -R www-data:www-data /var/www/html/MyProject/
RUN chmod -R 755 /var/www/html/MyProject/