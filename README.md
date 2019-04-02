# docker-apache-php-laravel

Un contenedor docker para desarrollar cosas locas en Laravel

```
$ docker build --build-arg projectname=miproyecto --build-arg hostname=laravel.test ./ -t laravel
$ docker run -it -p 8181:80 -v /c/Users/volumen/:/var/www/html/miproyecto laravel
```

Para windows recuerda agregar la siguiente línea al archivo C:\Windows\System32\drivers\etc\hosts
```
192.168.99.100 laravel.test
```

donde `192.168.99.100` es la dirección ip del contenedor, sí estas usando Docker toolbox usualmente la ip por default es `192.168.99.100` aunque en ciertos casos puede cambiar, si deseas verificar cual es la ip asignada abre una venta de docker quickstart terminal y en el mensaje de bienvenida se despliega la ip asignada.


Podrás ver la página por default de laravel en

http://laravel.test:8181/

Todo

[ ] Hot reloading
[ ] Test automation
[ ] Iniciar con un proyecto en blanco (solo Laravel) por defecto
[ ] Git cloning cuando se reciba un parametro


Basado en estas instrucciones 
https://websiteforstudents.com/install-laravel-php-framework-on-ubuntu-16-04-17-10-18-04-with-apache2-and-php-7-2-support/