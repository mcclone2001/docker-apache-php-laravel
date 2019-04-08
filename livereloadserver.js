/*
 CLI

 --directorios
        Especifica la lista de directorios a vigilar
 --extensiones
        Especifica las extensiones a vigilar
*/

var livereload = require('livereload');
var argv = require('minimist')(process.argv.slice(2));
var chalk = require('chalk');
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

serverConf.debug=false;
serverConf.usePolling=true;
serverConf.exts=argv.extensiones.replace(/\s/g, '').split(',');
serverConf.dirs=argv.directorios.replace(/\s/g, '').split(',');

var server = livereload.createServer( serverConf );
server.refresh = function(filepath) {
  var data;
  if(filepath.slice(-4)=='.php') {
  	console.log("Validando "+filepath);
  	const { spawnSync }=require('child_process');
  	res = spawnSync('php',["-l",filepath]);
  	if(res.status!=0) {
  		console.log(chalk.white.bgRed("*** ERROR DE SYNTAXIS ***"));
  		console.log(res.stdout.toString());
  		console.log(res.stderr.toString());
  		return;
  	}
  }
  console.log(chalk.black.bgGreen("Recargando por cambio a: " + filepath));
  data = JSON.stringify({
    command: 'reload',
    path: filepath,
    liveCSS: this.config.applyCSSLive,
    liveImg: this.config.applyImgLive,
    originalPath: this.config.originalPath,
    overrideURL: this.config.overrideURL
  });
  return this.sendAllClients(data);
};

server.watch( serverConf.dirs );
console.log( "Livereload iniciado" );