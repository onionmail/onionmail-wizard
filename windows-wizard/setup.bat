@echo off
color 1F
title OnionMail setup
cls
echo Setup...

if "%APPDATA%" == "" goto rte1
set ONIONMDATA=%APPDATA%\OnionMail
goto set1
:rte1
echo Operating system incompatibility
set ONIONMDATA=User
:set1
mkdir "%ONIONMDATA%" 2>nul
if exist "%ONIONMDATA%" goto slt1
echo Can't create %ONIONMDATA%
pause
:slt1
mkdir User 2>nul
mkdir User\tmp 2>nul
copy wizard\ntu.conf etc\ntu.conf
wizard -ap -f setup.conf
mkdir User\tmp 2>nul
exit
