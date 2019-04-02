FROM ubuntu:18.04

ARG projectname=MyProject
ARG hostname=example.com

ENV envprojectname=${projectname}

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install --yes \
	systemd \
	apache2 \
	git \
	curl \
  zip \
  unzip \
  tzdata \
  php7.2 libapache2-mod-php7.2 php7.2-mbstring php7.2-xmlrpc php7.2-soap php7.2-gd php7.2-xml php7.2-cli php7.2-zip php7.2-dom p7zip-full \
  libpng* build-essential gcc make autoconf libtool pkg-config nasm \
  && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
  && apt-get install --yes \
  nodejs

RUN npm install -g cross-env

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

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

VOLUME /var/www/html/${projectname}

COPY entrypoint.sh /tmp

CMD /tmp/entrypoint.sh ${envprojectname}