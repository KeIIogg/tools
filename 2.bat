@echo off
@echo Download WSL Package......
powershell "(New-Object System.Net.WebClient).DownloadFile('https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi','%~dp0\wsl_update_x64.msi')"
@echo -----------------------------Complete!
@echo Download vcxsrv(for GUI)......
powershell "(New-Object System.Net.WebClient).DownloadFile('https://downloads.sourceforge.net/project/vcxsrv/vcxsrv/1.20.14.0/vcxsrv.1.20.14.0.installer.exe','%~dp0\vcxsrv.exe')"
@echo -----------------------------Complete!
@echo Install WSL Package......
msiexec.exe  /i " %~dp0\wsl_update_x64.msi" /passive /qn
@echo -----------------------------Complete!
@echo Install vcxsrv(for GUI)......
"%~dp0\vcxsrv.exe" /S /v"/qn"
@echo -----------------------------Complete!
@echo Delete download files......
del /q "%~dp0\wsl_update_x64.msi"
del /q "%~dp0\vcxsrv.exe"
@echo -----------------------------Complete!
@echo Execute vcxsrv......
"C:\Program Files\VcXsrv\xlaunch.exe"
@echo -----------------------------Complete!
@echo Unregister Ubuntu......
wsl --unregister Ubuntu-20.04
@echo -----------------------------Complete!
@echo Install Ubuntu......
@echo After Install Ubuntu, Enter your username and password and close the window
@echo And then, excute Xlaunch and open the file No.3
wsl --install -d Ubuntu-20.04

exit
