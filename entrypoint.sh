#!/bin/bash

echo "Instalación de Laravel en el Volumen"
echo "===================================="
echo "Verificando si hay archivos en /var/www/html/$1/"

if [ ! -z "$(ls -A /var/www/html/$1/)" ]; then
	echo "Ya existe una instalación previa"
else
	echo "Instalando laravel"
	cd /var/www/html/$1 && composer create-project laravel/laravel ./ --prefer-dist

	echo "Actualizando permisos"
	chown -R www-data:www-data /var/www/html/$1/
	chmod -R 755 /var/www/html/$1/
fi

echo "Instalación terminada"
apachectl -D FOREGROUND
exit 0