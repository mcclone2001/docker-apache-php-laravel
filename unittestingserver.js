/*
 CLI

 --codigo
    especifica la lista de directorios a observar

 --pruebas
    especifica la lista de directorios donde estan las pruebas de los directorios observados
*/

var argv = require('minimist')(process.argv.slice(2));
const chokidar = require('chokidar');
var chalk = require('chalk');

var directoriosDeCodigo = argv.codigo.replace(/\s/g, '').split(',');
var directoriosDePruebas = argv.pruebas.replace(/\s/g, '').split(',');
var mapeoDeDirectorios = mapearArreglos(directoriosDeCodigo,directoriosDePruebas);

function mapearArreglos(llaves,valores) {
  var mapeo = llaves.map(function(item, index, array) {
    var obj={};
    obj.codigo=item
    obj.prueba=valores[index];
    return(obj);
  } );
  return mapeo;
}

chokidar.watch(directoriosDeCodigo, { usePolling: true }).on('all', (event, path) => {
  if( noEsArchivoPHPNuevoOModificado(event,path) ) return;

  var par = mapeoDeDirectorios.find(function(element){ return(element.codigo==path.slice(0,element.codigo.length)) });

  var directorioDePruebas = par.prueba;
  var directorioDeCodigo = par.codigo;

  var rutaDePrueba = obtenerRutaDePrueba(directorioDeCodigo,path,directorioDePruebas);

  // https://stackoverflow.com/questions/20643470/execute-a-command-line-binary-with-node-js
  const { spawnSync } = require('child_process'),
  res = spawnSync('/var/www/html/MyProject/vendor/bin/phpunit', [ rutaDePrueba ]);
  if(res.status!=0) {
   console.log(chalk.white.bgRed("**ERROR** ("+res.status+") "+path+" **ERROR**"));
   console.log(res.stdout.toString());
   console.log(res.stderr.toString());
  } else {
   console.log(chalk.black.bgGreen("[  Ok   ] "+path));
  }
});

function noEsArchivoPHPNuevoOModificado(event,rutaDeArchivo) {
 return( event!='change' && event!='add' && !esPHP(rutaDeArchivo) );
}

function obtenerRutaDePrueba(rutaBase,rutaDeArchivo,baseDePrueba) {
 return( baseDePrueba + eliminarRutaBase(rutaBase,rutaDeArchivo).slice(0,-4) + "Test" + rutaDeArchivo.slice(-4) );
}

function eliminarRutaBase(rutaBase,rutaDeArchivo) {
 return( rutaDeArchivo.slice(0-(rutaDeArchivo.length-rutaBase.length)) );
}

function esPHP(rutaDeArchivo) {
 return( rutaDeArchivo.slice(-3).toLowerCase()=='php' );
}

console.log("Unit Testing Watcher Server Iniciado");