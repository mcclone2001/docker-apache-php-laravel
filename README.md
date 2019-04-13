# Un contenedor docker para desarrollar cosas locas en Laravel

* Autocontenido     - Sólo ejecuta inicio.bat y tendras un ambiente listo para empezar a desarrollar
* Livereload        - Olvidate de recargar manualmente la página del navegador
* Pruebas unitarias - Ejecuta las pruebas en cuanto guardas tus cambios

Asegurate de tener installado Docker Toolbox

Y tener los siguientes contenedores corriendo
```
docker run -d --rm --name redis redis
docker run -d --rm --name graphite -p 9080:80 -p 9081:81 -p 2003-2004:2003-2004 -p 2023-2024:2023-2024 -p 8125:8125/udp -p 8126:8126 hopsoft/graphite-statsd
```

Para usar Livereload recuerda agregar el script a todas tus páginas
```
<script src="http://laravel.test:35729/livereload.js?snipver=1"></script>
```

Para windows recuerda agregar la siguiente línea al archivo C:\Windows\System32\drivers\etc\hosts
```
192.168.99.100 laravel.test
```

donde `192.168.99.100` es la dirección ip del contenedor, sí estas usando Docker toolbox usualmente la ip por default es `192.168.99.100` aunque en ciertos casos puede cambiar, si deseas verificar cual es la ip asignada abre una venta de docker quickstart terminal y en el mensaje de bienvenida se despliega la ip asignada.

Importante, asegurate agregar una excepción al antivirus para que no monitoree la carpeta que uses como volumen (en el ejemplo ``/c/Users/volumen/``) para evitar problemas de permisos.

Ejecuta inicio.bat

Podrás ver la página por default de laravel en

http://laravel.test:80/


## Para ejecutar manualmente desde Docker Quickstart Terminal
```
$ docker build --build-arg hostname=laravel.test ./ -t laravel
$ docker run -it --rm --name laravel -p 80:80 -p 35729:35729 -v /c/Users/volumen/:/var/www/html/MyProject laravel
```

## Para usar LiveReload

Recuerda agregar el script a todas tus páginas

```
<script src="http://laravel.test:35729/livereload.js?snipver=1"></script>
```

Si deseas ver el log de Livereload agrega ``?LR-verbose`` a la url (``http://laravel.test:80/?LR-verbose``)

Todo

[x] Live reloading
  [x] Configurar extensiones y directorios vigilados desde un --build-arg/--env
[x] Test automation
  [x] Que tambien observe cambios en los directorios de pruebas
[x] Tomar rutas de carpetas para Livereload y Unittesting desde config.txt
  [ ] Que los parametros pasados a ``docker run`` en ``inicio.sh`` no necesiten la ruta completa, pasar el directorio base del proyecto a ``CMD entrypoint.sh``
[x] Iniciar con un proyecto en blanco (solo Laravel) por defecto
[X] Git cloning cuando se reciba un --build-arg/--env
[ ] Que notifique si la url ya esta agregada al archivo hosts
[ ] Que habra la url en el navegador una vez que arranque
[ ] Agregar observador de buenas prácticas, parametrizado por archivos (PHP_Codesniffer,php-testability,PHP-Parser)
[ ] Agregar a config.txt control del tiempo de polling para livereload (default 100ms)
[ ] Agregar silent installation de Docker Toolbox
[ ] Quitar dependencia de git bash en inicio.bat
[ ] Agregar inicio.bat para trabajar con Docker nativo
[ ] Agregar script para que se pueda usar en Linux

? - testing
/ - en proceso


Basado en estas instrucciones 
https://websiteforstudents.com/install-laravel-php-framework-on-ubuntu-16-04-17-10-18-04-with-apache2-and-php-7-2-support/
