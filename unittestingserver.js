/*
 CLI

 --codigo
    especifica la lista de directorios a observar

 --pruebas
    especifica la lista de directorios donde est  n las pruebas de los directorios observados
*/
var argv = require('minimist')(process.argv.slice(2));
const chokidar = require('chokidar');

chokidar.watch(['/var/www/html/MyProject/app/Clases'], { usePolling: true }).on('all', (event, path) => {
  if(event!='change' && event!='add') return;
  console.log(esPHP(path));
  console.log(obtenerRutaDePrueba("/var/www/html/MyProject/app/Clases/",path,"/var/www/html/MyProject/tests/Unit/"));
  // https://stackoverflow.com/questions/20643470/execute-a-command-line-binary-with-node-js
  const { spawnSync } = require('child_process'),
  res = spawnSync('/var/www/html/MyProject/vendor/bin/phpunit', ['/var/www/html/MyProject/tests/Unit/ExampleTest.php']);
  if(res.status!=0) {
   console.log("**ERROR** "+path);
   console.log(res.status);
   console.log(res.stdout.toString());
   console.log(res.stderr.toString());
  } else {
   console.log("[  Ok   ] "+path);
  }
});

function obtenerRutaDePrueba(rutaBase,rutaDeArchivo,baseDePrueba) {
 return( baseDePrueba + eliminarRutaBase(rutaBase,rutaDeArchivo).slice(0,-4) + "Test" + rutaDeArchivo.slice(-4) );
}

function eliminarRutaBase(rutaBase,rutaDeArchivo) {
 return( rutaDeArchivo.slice(0-(rutaDeArchivo.length-rutaBase.length)) );
}

function esPHP(rutaDeArchivo) {
 return( rutaDeArchivo.slice(-3).toLowerCase()=='php' );
}