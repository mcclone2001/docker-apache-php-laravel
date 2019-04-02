#!/bin/bash

echo "Instalación de Laravel en el Volumen"
echo "===================================="
echo "Verificando si hay archivos en /var/www/html/$1/"

if [ ! -z "$(ls -A /var/www/html/$1/)" ]; then
	echo "Ya existe una instalación previa"
else
	echo "Instalando laravel"
	cd /var/www/html/$1 && composer create-project laravel/laravel ./ --prefer-dist
	if [ ! "$(cd /var/www/html/$1 && npm ci)" ]; then
		echo "No se ha podido instalar npm con la opción ci"
		echo "procediendo con npm i"
		cd /var/www/html/$1 && npm cache clear --force && npm i
	fi

	echo "Actualizando permisos"
	chown -R www-data:www-data /var/www/html/$1/
	chmod -R 755 /var/www/html/$1/
fi

echo "Instalación terminada"
apachectl start
cd /var/www/html/$1 && npm run hot
exit 0