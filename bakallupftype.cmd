@echo off
for /f "delims=" %%a in ('wmic OS Get localdatetime  ^| find "."') do set dt=%%a
set YYYY=%dt:~0,4%
set MM=%dt:~4,2%
set DD=%dt:~6,2%
set HH=%dt:~8,2%
set Min=%dt:~10,2%
set Sec=%dt:~12,2%
set stamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%
::robocopy "%cd%" "%cd%\__bakfiles\%stamp%" *.php *.phtml *.xml *.css *.js *.bat *.cmd *.sublime-snippet
::robocopy "%cd%" "%cd%\__bakfiles\%stamp%" *.php *.phtml *.xml *.css *.js
robocopy "%cd%" "%cd%\__bakfiles\%stamp%" *.php *.phps *.phtml *.xml *.css *.less *.regex *.js *.sublime-snippet *.sublime-completion
echo "All files of directory %cd% were copied to %cd%\__bakfiles\%stamp% !!!"
pause > nul