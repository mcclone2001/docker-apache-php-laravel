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
  if [ -f "$1" ]; then
  	ls
  	source $1
    docker run -d --name redis redis
  	docker run -it --rm --name laravel -p 80:80 -p 35729:35729 -v $rutavolumen:/var/www/html/MyProject -e "envextensiones=$envextensiones" -e "envdirectorios=$envdirectorios" -e "envtestingdirectorioscodigo=$envtestingdirectorioscodigo" -e "envtestingdirectoriospruebas=$envtestingdirectoriospruebas" -e "giturl=$giturl" -e "gitbranch=$gitbranch" -e "gitcommit=$gitcommit" --link redis:redis_server --link graphite:graphite_server laravel
  else
  	docker run -it --rm --name laravel -p 80:80 -p 35729:35729 laravel
  fi  
fi
