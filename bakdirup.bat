@ECHO off
FOR /f "tokens=2-4 delims=/ " %%a in ('DATE /t') do (SET strdate=%%c-%%a-%%b)
FOR /f "tokens=1-2 delims=/:" %%a in ('TIME /t') do (SET strtime=%%a%%b)
SET /p folderName="Folder to backup ? "
SET strCurrDate=%strdate%_%strtime%
XCOPY "%cd%\%folderName%" "%cd%\__bakdirs\%strCurrDate%\%folderName%" /I /D
ECHO "Folder copied !!!"
EXIT
