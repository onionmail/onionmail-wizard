@echo off
color 1f
title OnionMail Bundle 1.0
cls

echo OnionMail Bundle 1.0

set MYPATH=.
if exist ambient.bat goto nosup
echo Wizard setup...
mkdir User 2>nul
mkdir User\tmp 2>nul
wizard.exe -ap -f setup.conf
:nosup
if not exist ambient.bat goto rte1
call "ambient.bat"
if "%MYPATH%" == "." goto rte1
if "%ONIONMDATA%" == "" goto rte1

set VUSER=%MYPATH%\User
set TOR=%MYPATH%\User\Tor
set PATH=%MYPATH%;%PATH%;%MYPATH%\GnuPG2\bin;%MYPATH%\GnuPG2;%MYPATH%\tor;%MYPATH%\wizard
if "%MYTEMP%" == "" goto stmp
set TMP=%MYTEMP%
set TEMP=%MYTEMP%
goto mktmp
:stmp
set TMP=%MYPATH%\User\tmp
set TEMP=%MYPATH%\User\tmp
:mktmp
if not exist "%TMP%" mkdir %TMP%

cd /d "%MYPATH%"
mkdir User\tmp 2>nul
mkdir "%TMP%" 2>nul

taskkill /F /IM tor-onm.exe 2> nul
taskkill /F /IM ntu.exe 2> nul
taskkill /F /IM claws-mail.exe 2> nul

if "%1" == "-d" goto salto

if not exist "%ONIONMDATA%\wizard.done" goto noparam
if "%1" == "-w" goto wizard
:noparam
if exist "%ONIONMDATA%\wizard.done" goto salto
title OnionMail setup Wizard console
echo Running wizard...
:wizard
wizard.exe -ap -f wizard.conf
if exist "%ONIONMDATA%\wizard.ok" goto noproblem
color C0
title Error
echo Wizard error manual configuration required.
wizard.exe -err "Wizard aborted. Retry or use Claws-Mail without wizard configuration."
color 07

goto ende
:noproblem
echo 1 > "%ONIONMDATA%/wizard.done"
:salto
echo Starting TOR
title OnionMail + NTU + TOR Console
start /B TOR\tor-onm.exe -f "%TORPATH%\torrc"
echo Waiting for tor...

if not exist "%TORPATH%\cached-microdescs" wizard.exe -ti 127.0.0.1 -tp 9154 -tt 60 -tr 25 -ttt
if exist "%TORPATH%\cached-microdescs" wizard.exe -ti 127.0.0.1 -tp 9154 -tt 23 -tr 15 -ttt

echo Running NTU...
start /B ntu.exe -f "%MYPATH%\etc\ntu.conf"

echo Do not close this console window.

echo Start Claws-Mail
cd GnuPG2
claws-mail.exe

echo Close all process...
taskkill /F /IM tor-onm.exe 2>nul
taskkill /F /IM ntu.exe 2>nul
cd /d "%MYPATH%"
echo Clear main MRU and Windows user logging
regedit /S ClearMainMRU.reg
echo Erase TMP
regedit /S eula1.reg
sdelete -p 2 -s -q "%TMP%\*.*" >nul 2>nul
del /-P /S /Q "%TMP%\*.*" 2>nul
mkdir "%TMP%" 2>nul

goto ende
:rte1
title Error
color 0C
echo Setup error reinstall wizard.
pause
:ende
color 07
title DOS
