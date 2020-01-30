@echo off
if "%1" == "" (
	echo To get help you need to run with a key /?
	exit /b
)

if "%1" == "/?" (
	echo This script converts all txt-files lying in the transferred directory to files with utf-8 encoding
	exit /b
)

if not exist %1 (
	echo Transferred directory does not exist
	exit /b
)

:getNewName
set tempfile=%RANDOM%.txt
if exist %tempfile% (
	goto getNewName
)

for /R %1 %%A IN (*.txt) do (
	iconv -f cp866 -t utf-8 %%A>%tempfile%
	copy %tempfile% %%A>nul
)
del /q %tempfile%