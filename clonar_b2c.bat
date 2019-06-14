set directorio=C:\Users\volumen
set giturl=http://automaton:1234567890@192.168.1.68:30000/conclave/tripya2.git
set gitbranch=develop_2.0.0
set gitsubmodulebranch=develop

set dir_app_paquete_compra=public\paquete-compra
set dir_paquete_compra=packages\yacenter\compra\paquete-compra

cd %directorio%
git clone --recurse-submodules --single-branch -b %gitbranch% %giturl% .
git submodule foreach --recursive git checkout %gitsubmodulebranch%
echo ***** COMPOSER INSTALL
call composer install
echo ***** NPM CI
call npm ci
echo ***** NPM CI --prefix packages/yacenter/compra
call npm ci --prefix packages/yacenter/compra
echo ***** NPM RUN prod
call npm run prod
echo ***** PHP ARTISAN vendor:publish --provider="YaCenter\compra\CompraServiceProvider"
call php artisan vendor:publish --provider="YaCenter/compra/CompraServiceProvider"
echo ***** NPM RUN compilar-paquete --prefix packages/yacenter/compra
call npm run compilar-paquete --prefix packages/yacenter/compra
echo ***** MKLINK /J %dir_app_paquete_compra% %dir_paquete_compra%
mklink /J %dir_app_paquete_compra% %dir_paquete_compra%
copy .env.docker .env