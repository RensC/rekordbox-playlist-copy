# Script Name:    rekordbox_copy.bat
# Author:         DJ Differens
# Created:        02-11-2024
# Version:        1.0
# Description:    Script for copying playlist(s) to folders.

@echo off

set current_directory=%~dp0

:menu
cls
echo =====================================
echo          Select an Option
echo =====================================
echo 1. Copy all playlists
echo 2. Copy one playlist only
echo 3. Confirm each playlist individually
echo 4. Exit
echo =====================================
set /p choice="Enter your choice (1-4): "

:: Act based on the user's choice
if "%choice%"=="1" goto option1
if "%choice%"=="2" goto option2
if "%choice%"=="3" goto option3
if "%choice%"=="4" goto exit
echo Invalid choice, please select again.
pause
goto menu

:option1
set script_location="%current_directory%\powershell\copy_all_playlists.ps1"
powershell.exe -ExecutionPolicy Bypass -File %script_location%
pause
goto menu

:option2
set script_location="%current_directory%\powershell\copy_playlist.ps1"
powershell.exe -ExecutionPolicy Bypass -File %script_location%
pause
goto menu

:option3
set script_location="%current_directory%\powershell\copy_playlists.ps1"
powershell.exe -ExecutionPolicy Bypass -File %script_location%
pause
goto menu

:exit
echo Exiting...
pause
exit




