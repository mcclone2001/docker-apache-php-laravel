# docker-apache-php-laravel

Un contenedor docker para desarrollar cosas locas en Laravel

```
$ docker build --build-arg hostname=laravel.test ./ -t laravel
$ docker run -it --rm --name laravel -p 80:80 -p 35729:35729 -v /c/Users/volumen/:/var/www/html/MyProject laravel
```

Para windows recuerda agregar la siguiente línea al archivo C:\Windows\System32\drivers\etc\hosts
```
192.168.99.100 laravel.test
```

donde `192.168.99.100` es la dirección ip del contenedor, sí estas usando Docker toolbox usualmente la ip por default es `192.168.99.100` aunque en ciertos casos puede cambiar, si deseas verificar cual es la ip asignada abre una venta de docker quickstart terminal y en el mensaje de bienvenida se despliega la ip asignada.

Importante, asegurate agregar una excepción al antivirus para que no monitoree la carpeta que uses como volumen (en el ejemplo ``/c/Users/volumen/``) para evitar problemas de permisos.


Podrás ver la página por default de laravel en

http://laravel.test:80/

## Para usar LiveReload

Recuerda agregar el script a todas tus páginas

``
<script src="http://laravel.test:35729/livereload.js?snipver=1"></script>
``

Si deseas ver el log de Livereload agrega ``?LR-verbose`` a la url (``http://laravel.test:80/?LR-verbose``)

Todo

[x] Live reloading
  [?] Configurar extensiones y directorios vigilados desde un --build-arg/--env
[ ] Test automation
[x] Iniciar con un proyecto en blanco (solo Laravel) por defecto
[ ] Git cloning cuando se reciba un --build-arg/--env


Basado en estas instrucciones 
https://websiteforstudents.com/install-laravel-php-framework-on-ubuntu-16-04-17-10-18-04-with-apache2-and-php-7-2-support/
