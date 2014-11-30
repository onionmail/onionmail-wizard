@echo off
title OnionMail user Reset
color C0
cls
echo This script delete all OnionMail User Data!
echo This delete ALL Claws-Mail profile.
echo Backup your data before run this script.
echo Are you sure????
echo To terminate and do nothing press CTRL+C
echo To continue an delete all press ENTER.
pause
color 1F
cls
echo Clear all USER Data
if not exist wizard.exe goto rte1
if "%APPDATA%" == "" goto rte2

wizard.exe -apx 

regedit /S eula1.reg
sdelete -p 1 -s -q User\tmp\*.*
mkdir User\tmp 2> nul

taskkill /F /IM tor-onm.exe 2>nul
taskkill /F /IM ntu.exe 2>nul
taskkill /F /IM claws-mail.exe 2>nul
taskkill /F /IM wizard.exe 2>nul

del ambient.bat 2>nul
del autopath.bat 2>nul
copy wizard\ntu.conf etc\ntu.conf
  
sdelete -p 1 -s -q "%APPDATA%\claws-mail" 2>nul
sdelete -p 1 -s -q "%APPDATA%\TorONM"	  2>nul
dir /b "%APPDATA%\OnionMail*" > delist
for /F %%i in (delist) do sdelete -p 1 -s -q "%%i"
del delist
echo Now i try to reinstall all.
pause
cls
call setup
exit
:rte1
color 07
echo PATH error!
echo Check the path before launch this script.
pause
goto ende
:rte2
color 07
echo System incompatibility.
pause
:ende
