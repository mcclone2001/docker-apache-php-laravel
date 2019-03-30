# docker-apache-php-laravel
Un entorno para desarrollar APIs puras en Laravel

```
$ docker build ./ -t laravel
$ docker run -it -p 80:80 laravel
```

Para windows recuerda agregar la siguiente línea a tu archivo C:\Windows\System32\drivers\etc\hosts
```
192.168.99.101 example.com
```