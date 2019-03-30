FROM ubuntu:18.04

ARG projectname=MyProject
ARG hostname=example.com

RUN apt-get update && apt-get install --yes \
	systemd \
	apache2 \
	git \
	curl
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
RUN apt-get update && apt-get install --yes php7.2 libapache2-mod-php7.2 php7.2-mbstring php7.2-xmlrpc php7.2-soap php7.2-gd php7.2-xml php7.2-cli php7.2-zip
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
WORKDIR /var/www/html
RUN composer create-project laravel/laravel ${projectname} --prefer-dist
RUN chown -R www-data:www-data /var/www/html/${projectname}/
RUN chmod -R 755 /var/www/html/${projectname}/

RUN echo '<VirtualHost *:80> \n\
             ServerAdmin admin@example.com \n\
             DocumentRoot /var/www/html/'${projectname}'/public \n\
             ServerName '${hostname}' \n\
             <Directory /var/www/html/'${projectname}'/public> \n\
               Options +FollowSymlinks \n\
               AllowOverride All \n\
               Require all granted \n\
             </Directory> \n\
             ErrorLog ${APACHE_LOG_DIR}/error.log \n\
             CustomLog ${APACHE_LOG_DIR}/access.log combined \n\
           </VirtualHost>' >> /etc/apache2/sites-available/laravel.conf

RUN cat /etc/apache2/sites-available/laravel.conf

RUN a2ensite laravel.conf
RUN a2enmod rewrite
EXPOSE 80
CMD apachectl -D FOREGROUND

# https://websiteforstudents.com/install-laravel-php-framework-on-ubuntu-16-04-17-10-18-04-with-apache2-and-php-7-2-support/