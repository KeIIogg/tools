#!/usr/bin/bash
# -*- coding: utf-8 -*-

echo
echo
echo ==============================================================
echo 단계 4: Ubuntu 필요 유틸 및 Plot juggler 설치
echo ==============================================================
echo                Plot juggler 인스톨러
echo.
echo            [설치는 순차적으로 진행되어야 합니다!]
echo ==============================================================
echo
echo
echo
echo  .bashrc 에 필요한 명령어들 추가중....
# 백업 파일 생성
cp /home/$USER/.bashrc /home/$USER/.bashrc.bak

# 추가할 명령어들
COMMANDS=$(cat <<'EOT'
# Add execute Plotjuggler command line
alias op_plot='cd ~/openpilot/tools/plotjuggler && ./juggle.py --stream'

# Python directory -> openpilot
export PYTHONPATH="/home/$USER/openpilot/.venv/bin/python3:/home/$USER/openpilot"

# qt display setting (network)
export DISPLAY="$(grep nameserver /etc/resolv.conf | sed 's/nameserver //'):0"
export LIBGL_ALWAYS_INDIRECT=1
export DISPLAY=$WSL_IF_IP:0
unset LIBGL_ALWAYS_INDIRECT

# Execute poetry
cd ~/openpilot && poetry shell

# initial directory
cd ~
EOT
)

# .bashrc 파일에 명령어들 추가
while read -r line; do
    # 해당 명령어가 이미 .bashrc에 존재하는지 확인
    if ! grep -qF "$line" /home/$USER/.bashrc; then
        echo "$line" >> /home/$USER/.bashrc
    else
        echo "명령어가 이미 .bashrc에 존재합니다: $line"
    fi
done <<< "$COMMANDS"

echo ".bashrc 파일에 명령어들 추가 [[완료]]"
echo
echo
echo "Ubuntu 업데이트 및 업그레이드 중..."
cd ~
sudo apt update -y 
sudo apt upgrade -y 
echo
echo
echo "Ubuntu 업데이트 및 업그레이드 [[완료]]"


echo
echo
echo "x11-apps 설치 중..."
sudo apt install -y x11-apps
echo
echo
echo "x11-apps 설치 [[완료]]"


echo
echo
echo "Python3-pip 설치 중..."
if ! command -v pip3 &> /dev/null
then
    sudo apt install -y python3-pip
fi
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py
pip3 install pip --upgrade
sudo pip install --ignore-installed poetry
sudo apt install -y python3-testresources
echo
echo
echo "Python3-pip 설치 [[완료]]"


echo
echo
echo "Poetry 초기화 중..."
if ! command -v poetry &> /dev/null
then
    poetry init -n
fi
echo
echo
echo "Poetry 초기화 [[완료]]"


echo
echo
echo "Numpy 설치 중..."
if ! python3 -c 'import numpy' &> /dev/null
then
    pip3 install numpy
fi
echo
echo
echo "Numpy 설치 [[완료]]"


echo
echo
echo "Scons 설치 중..."
sudo apt install scons
pip3 install scons
echo
echo
echo "Scons 설치 [[완료!!]]"


echo
echo
echo "Git-LFS 설치 중..."
if ! command -v git-lfs &> /dev/null
then
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
    sudo apt-get update
    sudo apt install git-lfs
fi
echo
echo
echo "Git-LFS 설치 [[완료!!]]"


echo
echo
echo "Git LFS를 사용하여 OPENPILOT 다운로드 중..."
cd ~
git clone --filter=blob:none --recurse-submodules --also-filter-submodules https://github.com/commaai/openpilot.git
cd ~/openpilot
git lfs pull
echo
echo
echo "Git LFS를 사용하여 OPENPILOT 다운로드 [[완료!!]]"


echo
echo
echo "Plot juggler를 위한 명령어 실행 중..."
export PYTHONPATH="/home/$USER/openpilot/.venv/bin/python3:/home/$USER/openpilot"
export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"
export LIBGL_ALWAYS_INDIRECT=1
export DISPLAY=$WSL_IF_IP:0
unset LIBGL_ALWAYS_INDIRECT


echo
echo
echo "오픈파일럿내 필요유틸 설치 중..."
cd ~/openpilot&&tools/ubuntu_setup.sh
echo
echo
echo "오픈파일럿내 필요유틸 설치 [[완료]]"
 

echo
echo
echo "Poetry 가상환경 활성화 중..."
cd ~/openpilot&&poetry shell
echo
echo
echo "Poetry 가상환경 활성화 [[완료]]"


echo
echo
echo " 오픈파일럿 빌드 중..."
scons -u -j$(nproc)&&
echo
echo
echo " 오픈파일럿 빌드 [[완료]]"


echo
echo
echo "Plot juggler 설치 중..."
cd ~/openpilot/tools/plotjuggler&&./juggle.py --install


echo
echo
echo "Plot juggler 설치 [[완료]]"
echo
echo
echo "Ubuntu 를 재시작 후"
echo "op_plot 을 입력하면 Plot juggler가 실행됩니다."
echo
echo
read -n 1 -s -r -p "아무키를 입력하면 Ubuntu가 재시작 됩니다"

echo
echo
echo "Ubuntu를 재시작합니다"
wsl --shutdown
