#!/bin/sh
if test ! -z "$(docker images -q laravel:latest)"; then
  echo "Ya existe la imagen Laravel"
else
  echo "Creando la imagen Laravel"
  docker build --build-arg hostname=laravel.test ./ -t laravel
fi

if docker container inspect laravel; then
  echo "Ya existe el contenedor Laravel"
  if [ $(docker inspect -f '{{.State.Running}}' laravel) = "true" ]; then
    docker attach laravel
  fi
else
  echo "Creando el contenedor Laravel"
  if [ -f "config.txt" ]; then
  	ls
  	source ./config.txt
  	docker run -it --rm --name laravel -p 80:80 -p 35729:35729 -v /c/Users/volumen/:/var/www/html/MyProject -e "envextensiones=$envextensiones" -e "envdirectorios=$envdirectorios" -e "envtestingdirectorioscodigo=$envtestingdirectorioscodigo" -e "envtestingdirectoriospruebas=$envtestingdirectoriospruebas" laravel
  else
  	docker run -it --rm --name laravel -p 80:80 -p 35729:35729 -v /c/Users/volumen/:/var/www/html/MyProject laravel
  fi  
fi
