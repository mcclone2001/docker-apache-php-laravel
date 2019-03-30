# docker-apache-php-laravel
Un entorno para desarrollar APIs puras en Laravel

```
$ docker build --build-arg projectname=miproyecto --build-arg hostname=laravel.test ./ -t laravel
$ docker run -it -p 8181:80 laravel
```

Para windows recuerda agregar la siguiente línea a tu archivo C:\Windows\System32\drivers\etc\hosts
```
192.168.99.100 laravel.test
```

donde `192.168.99.100` es la dirección ip del contenedor, sí estas usando Docker toolbox usualmente la ip por default es `192.168.99.100`


Podrás ver la página por default de laravel en

http://laravel.test:8181/