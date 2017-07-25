::Backup all files in a directory:
@ECHO OFF
SET BAKDIR=%~dp0_bakfiles

FOR /F "DELIMS=" %%A IN ('WMIC OS GET LOCALDATETIME  ^| FIND "."') DO SET dt=%%A
SET YYYY=%dt:~0,4%
SET MM=%dt:~4,2%
SET DD=%dt:~6,2%
SET HH=%dt:~8,2%
SET Min=%dt:~10,2%
SET Sec=%dt:~12,2%
SET STAMP=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%

SET DESTINATION=%BAKDIR%\%STAMP%
MKDIR %DESTINATION%

FOR %%F in (%CD%\*.*) DO (
	IF %%~nxF NEQ %~n0%~x0 (
		COPY %%~nxF %DESTINATION%\%%~nxF
	)
)
PAUSE
