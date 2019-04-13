#!/bin/bash

# $1 - Directorio del proyecto dentro del contenedor

# $2 - Lista de extensiones a observar por Livereloadserver
# $3 - Lista de directorios a observar por Livereloadserver

# $4 - Lista de directorios de codigo fuente a observar por Unittestingserver
# $5 - Lista de directorios de pruebas unitarias a observar por Unittestingserver

# $6 - URL de repositorio Git a clonar (incluir usuario y contraseña en URL, inseguro, peor es nada)
# $7 - Rama del repositorio a clonar
# $8 - Commit específico a clonar


echo "Instalación de Laravel en el Volumen"
echo "===================================="
echo "Verificando si hay archivos en $1/"

if [ $6 ]; then
  if [ ! -d $1/.git ]; then
  	if [ $8 ]; then
  	  git clone -n $6
  	  git checkout --recurse-submodules -b $7 $8
  	else
  	  git clone --recurse-submodules --single-branch -b $7 $6 $1
  	fi    
  fi
fi

if [ ! -z "$(ls -A $1/)" ]; then

	echo "Ya existe una instalación previa"

	if [ ! -d "$1/vendor" ]; then
		echo "No existe la carpeta vendor"
		echo "Intentando con composer install"
		cd $1/ && composer install
	fi

	if [ ! -d "$1/node_modules" ]; then
		echo "No existe la carpeta node_modules"
		echo "Intentando instalar con npm ci"
		if [ ! "$(cd $1/ && npm ci --no-bin-links)" ]; then
			echo "No se ha podido instalar con npm ci"
			echo "Intentando con npm i"
			cd $1/ && npm cache verify && npm i --no-bin-links
		fi
	fi

else

	echo "Iniciando con una instalación limpia"

	echo "Instalando laravel"
	cd $1/ && composer create-project laravel/laravel ./ --prefer-dist
	echo "Instalando node_modules con npm i"
	cd $1/ && npm cache verify && npm i --no-bin-links
	echo "Instalando cliente de statsd"
	cd $1/ && composer require league/statsd
	echo "Instalación terminada"

fi

apachectl start
tmux new "cd $1/ && npm run watch" ';' split -h "nodejs /tmp/livereloadserver.js --extensiones \"$2\" --directorios \"$3\"" ';' select-p -t 0 ';' split -v "nodejs /tmp/unittestingserver.js --codigo=\"$4\" --pruebas=\"$5\"" ";" select-p -t 2 ';' split -v "/bin/bash"
exit 0
