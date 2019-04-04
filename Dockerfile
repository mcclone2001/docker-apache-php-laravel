FROM ubuntu:18.04

# valores por default para los argumentos
ARG hostname=example.com
ARG projectname=MyProject

# variables de entorno
ENV NODE_PATH=/usr/lib/node_modules
ENV envprojectname=${projectname}
ENV envextensiones="php, css, js"
ENV envdirectorios="/var/www/html/${projectname}/public, /var/www/html/${projectname}/resources/views"

# requisitos generales
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

# Requisitos para webpack
RUN npm install -g npm@latest
RUN npm install -g cross-env

# Requisitos para livereload
RUN npm install -g livereload
RUN npm install -g minimist

# composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# configurando apache
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

# configurando el volumen
VOLUME /var/www/html/${projectname}

# copiando scripts
COPY entrypoint.sh /tmp
COPY livereloadserver.js /tmp

#Puerto de Apache2
EXPOSE 80

#Puerto de Livereload
EXPOSE 35729

# punto de entrada
CMD /tmp/entrypoint.sh ${envprojectname} "${envextensiones}" "${envdirectorios}"