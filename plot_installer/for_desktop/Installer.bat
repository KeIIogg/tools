@echo off
chcp 65001 >nul 2>&1

:: 관리자 권한으로 실행되었는지 확인
>nul 2>&1 "%SYSTEMROOT%\System32\cacls.exe" "%SYSTEMROOT%\System32\config\system"

::  %errorlevel% 값이 0보다 크면 관리자 권한으로 실행되지 않음
if %errorlevel% NEQ 0 (
    echo 현재 관리자 권한으로 실행되지 않았습니다.
    echo 종료 후 마우스 우클릭을 통해 관리자권한으로 실행해주세요
    pause
    exit /b
)
echo.
echo 현재 관리자 권한으로 실행 중입니다.
echo.

setlocal enableDelayedExpansion

:: xlaunch.exe 파일의 존재 여부 확인
if exist "C:\Program Files (x86)\VcXsrv\xlaunch.exe" (
    :: xlaunch.exe가 존재하는 경우, Step3으로 이동
    echo 단계 3 부터 이어서 설치 진행됩니다.
    echo.
    goto Step3
) else (
    :: xlaunch.exe가 존재하지 않는 경우, WSL 기능 상태 확인
    wsl --list --online >nul 2>&1
    if %errorlevel% equ 0 (
        :: WSL이 활성화된 경우, Step2로 이동
        echo 단계 2 부터 이어서 설치 진행됩니다.
        echo.
        goto Step2
    ) else (
        :: WSL이 비활성화된 경우, Step1로 이동
        echo.
        goto Step1
    )
)

:Step1
cls
echo.
echo ==============================================================
echo 단계 1: Windows Subsystem for Linux (WSL) 설정
echo ==============================================================
echo                Plot juggler 인스톨러
echo.
echo            [설치는 순차적으로 진행되어야 합니다!]
echo ==============================================================
echo.
echo.
echo  WSL 활성화 중...
echo.
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
echo.
echo  WSL 설치 완료.
echo.
echo.
echo  가상 머신 플랫폼 활성화 중...
echo.
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
echo.
echo  가상 머신 플랫폼 활성화 완료.
echo.
echo.
echo  WSL2 기본 버전 설정 중...
echo.
wsl --set-default-version 2
echo.
echo  WSL2 기본 버전 설정 완료.
echo.
echo.
echo.
echo ==============================================================
echo  계속하려면 아무 키나 눌러 재부팅하세요... 
echo.
echo  재부팅 후 설치 스크립트를 다시 실행하세요.
echo ==============================================================
echo.
pause >nul

echo.
echo  재부팅 중...
echo.
shutdown -r -t 0
echo.
goto :EOF

:Step2
cls
echo.
echo ==============================================================
echo 단계 2: 필요한 패키지 및 도구 설치
echo ==============================================================
echo                Plot juggler 인스톨러
echo.
echo            [설치는 순차적으로 진행되어야 합니다!]
echo ==============================================================
echo.
echo.

echo .
echo  WSL 패키지 다운로드 중...
echo.
powershell "(New-Object System.Net.WebClient).DownloadFile('https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi','%~dp0\wsl_update_x64.msi')"
echo.
echo  WSL 패키지 다운로드 완료.
echo.
echo.
echo  Vcxsrv (GUI용) 다운로드 중...
echo.
powershell "(New-Object System.Net.WebClient).DownloadFile('https://downloads.sourceforge.net/project/vcxsrv/vcxsrv/1.20.14.0/vcxsrv.1.20.14.0.installer.exe','%~dp0\vcxsrv.exe')"
echo.
echo  Vcxsrv (GUI용) 다운로드 완료.
echo.
echo.
echo  WSL 패키지 설치 중...
msiexec.exe /i "%~dp0\wsl_update_x64.msi" /passive /qn
echo WSL 패키지 설치 완료.

echo.
echo  Vcxsrv (GUI용) 설치 중...
"%~dp0\vcxsrv.exe" /S /v"/qn"
echo  Vcxsrv (GUI용) 설치 완료.

echo.
echo  다운로드 파일 삭제 중...
del /q "%~dp0\wsl_update_x64.msi"
del /q "%~dp0\vcxsrv.exe"
echo 다운로드 파일 삭제 완료.

echo.
echo  Vcxsrv-Xlaunch 실행 중...
"C:\Program Files\VcXsrv\xlaunch.exe"
echo  Vcxsrv 실행 완료.

echo.
echo  이전 Ubuntu 등록 해제 중...
wsl --unregister Ubuntu-20.04

echo ==============================================================
echo  Ubuntu-20.04 설치를 계속하려면 아무 키나 눌러 진행하세요.
echo  설치가 완료되면, 아이디 및 비밀번호를 이어서 설정합니다.
echo  설정 완료 후 해당 창을 닫으시고, 설치 스크립트를 재실행 해주세요.
echo ==============================================================
pause >nul
echo.
echo  Ubuntu-20.04 설치 중..
wsl --install -d Ubuntu-20.04
echo.
echo.
pause
goto :EOF

:Step3
cls
echo.
echo ==============================================================
echo 단계 3: Plot juggler 설치
echo ==============================================================
echo                Plot juggler 인스톨러
echo.
echo            [설치는 순차적으로 진행되어야 합니다!]
echo ==============================================================
echo.
echo.
echo.
echo ==============================================================
echo  Plot juggler 설치를 이어서 진행하려면 아무 키나 눌러 진행하세요.
echo  이후 '단계 4' 는 Ubuntu 환경에서 설치가 진행됩니다.
echo ==============================================================
pause >nul
echo.
echo  Plot juggler 설치파일들을 Git으로부터 복사 중...
echo.
echo  실행 스크립트 실행 중...
echo.
echo  '단계 4' 로 이어서 진행됩니다.
echo.
echo.
wsl -- git clone https://github.com/Keiiogg/tools.git /home/shko/tools
wsl -- chmod +x /home/shko/tools/plot_installer/installer.sh
wsl -- /home/shko/tools/plot_installer/installer.sh
pause
goto :EOF
