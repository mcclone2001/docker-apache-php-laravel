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
  	source $1
    docker run -d --rm --name redis -p 6379:6379 redis
    docker run -d --rm --name graphite -p 9080:80 -p 9081:81 -p 2003-2004:2003-2004 -p 2023-2024:2023-2024 -p 8125:8125/udp -p 8126:8126 hopsoft/graphite-statsd
  	docker run -it --rm --name laravel -p 80:80 -p 35729:35729 -v $rutavolumen:/var/www/html/MyProject -e "envextensiones=$envextensiones" -e "envdirectorios=$envdirectorios" -e "envtestingdirectorioscodigo=$envtestingdirectorioscodigo" -e "envtestingdirectoriospruebas=$envtestingdirectoriospruebas" -e "giturl=$giturl" -e "gitbranch=$gitbranch" -e "gitcommit=$gitcommit" --link redis:redis_server --link graphite:graphite_server laravel
    docker stop redis graphite
  else
  	docker run -it --rm --name laravel -p 80:80 -p 35729:35729 laravel
  fi  
fi
