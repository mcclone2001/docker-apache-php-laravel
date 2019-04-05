/*
 CLI

 --directorios
        Especifica la lista de directorios a vigilar
 --extensiones
        Especifica las extensiones a vigilar
*/

var livereload = require('livereload');
var argv = require('minimist')(process.argv.slice(2));

console.log(argv);

var abortar = false;

if(!tiene(argv,'extensiones')) {
 console.log("no hay extensiones especificadas");
 console.log("Ejemplo:")
 console.log(" --extensiones 'php, css, js'");
 abortar = true;
}

if(!tiene(argv,"directorios")) {
 console.log("no hay directorios especificados");
 console.log("Ejemplo:");
 console.log(" --directorios '/var/www/html/proyecto/public, /var/www/html/proyecto/app'");
 abortar = true;
}

if(abortar) {
 process.exit(2);
}

function tiene(objeto,nombrePropiedad) {
 return objeto.hasOwnProperty(nombrePropiedad);
}

var serverConf = {};
serverConf.debug=true;
serverConf.usePolling=true;
serverConf.exts=argv.extensiones.replace(/\s/g, '').split(',');
serverConf.dirs=argv.directorios.replace(/\s/g, '').split(',');

console.log(serverConf);


var server = livereload.createServer( serverConf );
server.watch( serverConf.dirs );
console.log( "Livereload iniciado" );