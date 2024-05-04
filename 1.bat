@echo off
echo Enable Windows-Subsystem-Linux.....
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
echo ----------------------Complete!
echo Enable VirtualMachinePlatform.....
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
echo ----------------------Complete!
echo Set WSL2.....
wsl --set-default-version 2
echo ----------------------Complete!
echo Need to reboot
echo Do you want reboot?
echo If you want reboot, type 'y' or not type 'n'
set /p x=type :
if %x%==yes (goto y) else if %x%==n (goto n) 

:y 
shutdown -r -t 0
pause
goto exit

:n
echo Cancel reboot...
echo However, this is an operation that definitely requires a reboot. After rebooting, proceed with file no. 2.
pause
goto exit