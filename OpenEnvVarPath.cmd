@echo off
SET
setlocal enableextensions
set /p EnvVar="Enter the variable name: "
setlocal enabledelayedexpansion
pushd "!%EnvVar%!"
start.
endlocal
pause > nul
exit /b
goto :eof