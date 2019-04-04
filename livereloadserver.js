var livereload = require('livereload');

const extensionsToWatch = [
  'php',
  'js',
  'css'
];

var server = livereload.createServer({debug:true,exts:extensionsToWatch,usePolling: true});
server.watch("/var/www/html/miproyecto/public");
console.log("iniciado");