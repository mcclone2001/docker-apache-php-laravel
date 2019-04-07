echo off
cls
echo Iniciando
SET _ruta=%~dp0
"C:\Program Files\Git\bin\bash.exe" --cd="%_ruta:~0,-1%" --login -i "C:\Program Files\Docker Toolbox\start.sh" "./inicio.sh"
