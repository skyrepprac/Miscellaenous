::Backup file and rename
@echo off
for /f "delims=" %%a in ('wmic OS Get localdatetime  ^| find "."') do set dt=%%a
set /p FILE_TO_BAKP="Enter Filename: "
set YYYY=%dt:~0,4%
set MM=%dt:~4,2%
set DD=%dt:~6,2%
set HH=%dt:~8,2%
set Min=%dt:~10,2%
set Sec=%dt:~12,2%
set stamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%
::echo f | xcopy /y /f "%CD%\%FILE_TO_BAKP%" "%CD%\_filebaks\%FILE_TO_BAKP%_%stamp%.bak"
::echo f | xcopy /y /f "%CD%\%FILE_TO_BAKP%" "%CD%\_filebaks\%FILE_TO_BAKP%_%stamp%.old"
::xcopy /y "%CD%\[Filename]" "%CD%\[Targetdir]\*" - Filenames should be same for both source and destination dirs
::Filenames can be different and it's less hacky
::xcopy /y "%CD%\[Filename]" "%CD%\[Targetdir]\%FILE_TO_BAKP%_%stamp%.*old"
xcopy /y "%CD%\%FILE_TO_BAKP%" "%CD%\__filebaks\%FILE_TO_BAKP%_%stamp%.bak*"
xcopy /y "%CD%\%FILE_TO_BAKP%" "%CD%\__filebaks\%FILE_TO_BAKP%_%stamp%.old*"
exit /b