echo off
cls
echo Iniciando
call config_general.bat
SET _ruta=%~dp0
%RUTA_BASH% --cd="%_ruta:~0,-1%" --login -i "%DOCKER_TOOLBOX_INSTALL_PATH%\start.sh" "./inicio.sh ./config.txt"
