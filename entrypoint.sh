#!/bin/bash

echo "Instalación de Laravel en el Volumen"
echo "===================================="
echo "Verificando si hay archivos en /var/www/html/$1/"

if [ ! -z "$(ls -A /var/www/html/$1/)" ]; then

	echo "Ya existe una instalación previa"

	if [ ! -d "/var/www/html/$1/vendor" ]; then
		echo "No existe la carpeta vendor"
		echo "Intentando con composer install"
		cd /var/www/html/$1 && composer install
	fi

	if [ ! -d "/var/www/html/$1/node_modules" ]; then
		echo "No existe la carpeta node_modules"
		echo "Intentando instalar con npm ci"
		if [ ! "$(cd /var/www/html/$1 && npm ci)" ]; then
			echo "No se ha podido instalar con npm ci"
			echo "Intentando con npm i"
			cd /var/www/html/$1 && npm cache verify && npm i --no-bin-links
		fi
	fi

else

	echo "Iniciando con una instalación limpia"

	echo "Instalando laravel"
	cd /var/www/html/$1 && composer create-project laravel/laravel ./ --prefer-dist
	echo "Instalando node_modules con npm i"
	cd /var/www/html/$1 && npm cache verify && npm i --no-bin-links
	echo "Instalación terminada"

fi

apachectl start
cd /tmp && nodejs livereloadserver.js &
cd /var/www/html/$1 && npm run watch
exit 0
