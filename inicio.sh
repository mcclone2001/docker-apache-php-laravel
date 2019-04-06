#!/bin/sh
if [ $(docker inspect -f '{{.State.Running}}' laravel) = "true" ]; then
  docker attach laravel
else
  docker run -it --rm --name laravel -p 80:80 -p 35729:35729 -v /c/Users/volumen/:/var/www/html/MyProject laravel
fi