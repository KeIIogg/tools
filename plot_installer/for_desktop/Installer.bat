@echo off
cls
pushd "%~dp0"
title Plog juggler for OPENPILOT INSTALLER
fltmc >nul 2>&1 || (
	echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
	echo UAC.ShellExecute "%~fs0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
	"%temp%\getadmin.vbs"
	del /f /q "%temp%\getadmin.vbs"
	exit /b
)
REG QUERY "HKU\S-1-5-19" >NUL 2>&1 && (
goto menu
) || (
echo Right click and run as administrator...
echo.
pause
goto exit
)
:menu
cls
@echo =======================================================================
@echo              Plot jugger installer for openpilot
@echo. 
@echo              [Must be Install SEQUENTIALLY !]
@echo.            
@echo       (1) Set up for install (in windows) [NEED TO REBOOT]
@echo           (2) Install tools for ubuntu (in windows)
@echo           (3) Install tools for plotjuggle (in ubuntu) 
@echo.
@echo ========================================================================
@echo.                 
set /p choice= Make your selection : 
set choice=%choice:~0,1%
if /i "%choice%"=="1" goto step1
if /i "%choice%"=="2" goto step2
if /i "%choice%"=="3" goto step3
goto menu

:step1
cls
@echo.
@echo.
@echo Enable Windows-Subsystem-Linux.....
@echo.
@echo.
@echo.
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
@echo.
@echo.
@echo.
@echo.
@echo ----------------------Complete!
@echo.
@echo.
@echo.
@echo Enable VirtualMachinePlatform.....
@echo.
@echo.
@echo.
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
@echo.
@echo.
@echo.
@echo.
@echo ----------------------Complete!
@echo.
@echo.
@echo.
@echo Set WSL2.....
@echo.
@echo.
@echo.
wsl --set-default-version 2
@echo.
@echo.
@echo.
@echo.
@echo ----------------------Complete!
@echo.
@echo.
@echo.
:reboot
@echo =====================================
@echo                   [ Need to reboot for install ]
@echo.                          
@echo               If you want reboot now, 'y' or not  'n'
@echo ======================================
@echo.
set /p choice2=  Make your selection:
set choice2=%choice2:~0,1%
if /i "%choice2%"=="y" goto yes
if /i "%choice2%"=="n" goto no
goto reboot

:yes
cls
shutdown -r -t 0

pause
goto exit

:no
cls
@echo.
@echo.
@echo.
@echo Cancel reboot...
@echo.
@echo.
@echo ======================================================================
@echo However, this is a process that definitely requires a reboot. After reboot, proceed with step.2
@echo ======================================================================

pause
goto menu


:step2
cls
@echo.
@echo.
@echo.
@echo.
@echo Download WSL Package......
@echo.
@echo.
@echo.
powershell "(New-Object System.Net.WebClient).DownloadFile('https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi','%~dp0\wsl_update_x64.msi')"
@echo.
@echo.
@echo.
@echo -----------------------------Complete!
@echo.
@echo.
@echo.
@echo Download vcxsrv(for GUI)......
@echo.
@echo.
@echo.
powershell "(New-Object System.Net.WebClient).DownloadFile('https://downloads.sourceforge.net/project/vcxsrv/vcxsrv/1.20.14.0/vcxsrv.1.20.14.0.installer.exe','%~dp0\vcxsrv.exe')"
@echo.
@echo.
@echo.
@echo -----------------------------Complete!
@echo.
@echo.
@echo.
@echo Install WSL Package......
@echo.
@echo.
@echo.
msiexec.exe  /i " %~dp0\wsl_update_x64.msi" /passive /qn
@echo.
@echo.
@echo.
@echo -----------------------------Complete!
@echo.
@echo.
@echo.
@echo Install vcxsrv(for GUI)......
@echo.
@echo.
@echo.
"%~dp0\vcxsrv.exe" /S /v"/qn"
@echo.
@echo.
@echo.
@echo -----------------------------Complete!
@echo.
@echo.
@echo.
@echo Delete download files......
@echo.
@echo.
@echo.
del /q "%~dp0\wsl_update_x64.msi"
@echo.
@echo.
@echo.
del /q "%~dp0\vcxsrv.exe"
@echo.
@echo.
@echo.
@echo -----------------------------Complete!
@echo.
@echo.
@echo.
@echo Execute vcxsrv......
@echo.
@echo.
@echo.
"C:\Program Files\VcXsrv\xlaunch.exe"
@echo.
@echo.
@echo.
@echo -----------------------------Complete!
@echo.
@echo.
@echo.
@echo Unregister Ubuntu......
@echo.
@echo.
@echo.
wsl --unregister Ubuntu-20.04
@echo.
@echo.
@echo.
@echo -----------------------------Complete!
@echo.
@echo.
@echo.
@echo Install Ubuntu......
@echo.
@echo.
@echo.
@echo After Install Ubuntu, Enter your username and password and close the window
@echo and close the window and then proceed with step.3
wsl --install -d Ubuntu-20.04

pause
goto exit

:step3
cls
@echo.
@echo.
@echo Install windows terminal.....
@echo.
@echo.
@echo.
dism.exe /online /enable-feature /featurename:MicrosoftWindowsClientLanguagePackRoot /all /norestart
set path=%PATH%;%systemroot%\System32\WindowsPowershell\v1.0\
@echo.
@echo.
@echo -----------------------------Complete!
@echo.
@echo.
@echo.
@echo Excute install script.....
wt wsl -e sh installer.sh

pause
