echo off
cls
echo Iniciando
call config_general.bat
if "%~1"=="" goto BLANK
if "%~1"=="-b2c" (goto B2C)
:B2C
echo Instalando ambiente B2C
call clonar_b2c.bat
goto BLANK
:BLANK
SET _ruta=%~dp0
%RUTA_BASH% --cd="%_ruta:~0,-1%" --login -i "%DOCKER_TOOLBOX_INSTALL_PATH%\start.sh" "./inicio.sh ./config.txt"
