#!/usr/bin/bash
# -*- coding: utf-8 -*-
echo
echo
echo ==============================================================
echo 단계 4: Ubuntu 필요 유틸 및 Plot juggler 설치
echo ==============================================================
echo                Plot juggler 인스톨러
echo
echo            [설치는 순차적으로 진행되어야 합니다!]
echo ==============================================================
echo
echo
echo
# .bashrc 파일 백업 경로 정의
backup_bashrc="$HOME/.bashrc.bak"
bashrc_file="$HOME/.bashrc"

# .bashrc 백업 파일이 없는 경우 .bashrc를 백업 파일로 복사
if [ ! -f "$backup_bashrc" ]; then
    cp "$bashrc_file" "$backup_bashrc"
    echo ".bashrc 파일이 백업되었습니다: $backup_bashrc"
else
    echo ".bashrc 파일의 백업이 이미 존재합니다: $backup_bashrc"
fi

# 명령어들을 배열로 정의
commands=(
    "export PYTHONPATH=\"/home/\$USER/openpilot/.venv/bin/python3:/home/\$USER/openpilot\""
    "export DISPLAY=\"\$(grep nameserver /etc/resolv.conf | sed 's/nameserver //'):0\""
    "export LIBGL_ALWAYS_INDIRECT=1"
    "export DISPLAY=\$WSL_IF_IP:0"
    "alias op_set='cd ~/openpilot && scons -u -j\$(nproc)'"
    "alias op_plot='cd ~/openpilot/tools/plotjuggler && ./juggle.py --stream'"
    "alias op_pc_set='cd ~/tools/op_pc_installer && ./installer.sh'"
    "alias op_pc='cd ~/tools/op_pc_installer && ./launch.sh'"
)

# .bashrc 파일에 각 명령어를 추가
for command in "${commands[@]}"; do
    if ! grep -qFx "$command" "$bashrc_file"; then
        echo "$bashrc_file에 명령어 추가 중: $command"
        echo "$command" >> "$bashrc_file"
    else
        echo "$bashrc_file에 이미 해당 명령어가 존재합니다. 스킵합니다: $command"
    fi
done

echo ".bashrc 파일 설정이 완료되었습니다."
echo
echo

# 함수: 명령어 실행 여부 확인 및 설치 스킵
run_or_skip_command() {
    local command="$1"
    local skip_message="$2"

    if ! command -v $command &> /dev/null
    then
        echo "[$command 설치 시작]"
        eval "$command"
        echo "[$command 설치 완료]"
    else
        echo "[$command 설치 스킵: $skip_message]"
    fi
}

echo "Ubuntu 업데이트 및 업그레이드 중..."
sudo apt update -y 
sudo apt upgrade -y 
echo "Ubuntu 업데이트 및 업그레이드 [[완료]]"


echo "x11-apps 설치 중..."
sudo apt install -y x11-apps
echo "x11-apps 설치 [[완료]]"


echo "Python3-pip 설치 중..."
run_or_skip_command "pip3" "이미 설치되어 있습니다."
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py
pip3 install pip --upgrade
sudo pip install --ignore-installed poetry
sudo apt install -y python3-testresources
echo "Python3-pip 설치 [[완료]]"


echo "Poetry 초기화 중..."
run_or_skip_command "poetry" "이미 초기화되었습니다."
poetry init -n
echo "Poetry 초기화 [[완료]]"


echo "Numpy 설치 중..."
run_or_skip_command "python3 -c 'import numpy'" "이미 설치되어 있습니다."
pip3 install numpy
echo "Numpy 설치 [[완료]]"


echo "Scons 설치 중..."
sudo apt install -y scons
pip3 install scons
echo "Scons 설치 [[완료!!]]"


echo "Git-LFS 설치 중..."
run_or_skip_command "git-lfs" "이미 설치되어 있습니다."
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get update
sudo apt install git-lfs
echo "Git-LFS 설치 [[완료!!]]"


echo "Git LFS를 사용하여 OPENPILOT 다운로드 중..."
cd ~
if [ ! -d "openpilot" ]; then
    git clone --filter=blob:none --recurse-submodules --also-filter-submodules https://github.com/commaai/openpilot.git
    cd ~/openpilot
    git lfs pull
else
    echo "OPENPILOT 이미 다운로드되어 있습니다. 스킵합니다."
fi
echo "Git LFS를 사용하여 OPENPILOT 다운로드 [[완료!!]]"


echo "Plot juggler를 위한 명령어 실행 중..."
export PYTHONPATH="/home/$USER/openpilot/.venv/bin/python3:/home/$USER/openpilot"
export DISPLAY="$(grep nameserver /etc/resolv.conf | sed 's/nameserver //'):0"
export LIBGL_ALWAYS_INDIRECT=1
export DISPLAY=$WSL_IF_IP:0
echo "Plot juggler 설치 중..."
cd ~/openpilot/tools/plotjuggler
./juggle.py --install
echo "Plot juggler 설치 [[완료]]"


echo "오픈파일럿 내 필요 유틸 설치 중..."
cd ~/openpilot && tools/ubuntu_setup.sh
echo "오픈파일럿 내 필요 유틸 설치 [[완료]]"
 

#echo "Poetry 가상환경 활성화 중..."
#cd ~/openpilot && poetry shell
#echo "Poetry 가상환경 활성화 [[완료]]"
echo "venv 가상환경 활성화 중..."
cd /home/$USER/openpilot/.venv && source bin/activate
echo "venv 가상환경 활성화 [[완료]]"

echo "오픈파일럿 빌드 중..."
scons -u -j$(nproc)
echo "오픈파일럿 빌드 [[완료]]"
echo
echo


source ~/.bashrc
echo "op_set을 입력하면 기존 오픈파일럿이 빌드됩니다.."
echo "op_plot을 입력하면 Plot juggler가 실행됩니다."
echo "op_pc_set을 입력하면 PC용 오픈파일럿 빌드됩니다."
echo "op_pc를 입력하면 PC용 오픈파일럿 실행됩니다."
echo
echo

