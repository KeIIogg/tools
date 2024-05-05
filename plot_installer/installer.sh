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
backup_bashrc="$HOME/.bashrc.bak"
bashrc_file="$HOME/.bashrc"

# .bashrc 파일이 존재하지 않는 경우 백업 생성
if [ ! -f "$backup_bashrc" ]; then
    cp "$bashrc_file" "$backup_bashrc"
    echo ".bashrc 파일이 백업되었습니다: $backup_bashrc"
else
    echo ".bashrc 파일의 백업이 이미 존재합니다: $backup_bashrc"
fi

# 필요한 Alias를 추가합니다 - Plotjuggler 실행
add_alias_if_not_exists() {
    local alias_name="$1"
    local alias_command="$2"

    # 이미 .bashrc에 Alias가 존재하지 않는 경우 추가
    if ! grep -qFx "alias $alias_name='$alias_command'" "$bashrc_file"; then
        echo "$bashrc_file에 Alias '$alias_name' 추가 중"
        echo "alias $alias_name='$alias_command'" >> "$bashrc_file"
    else
        echo "$bashrc_file에 이미 Alias '$alias_name'이(가) 존재합니다. 스킵합니다."
    fi
}

# PYTHONPATH를 .bashrc에 추가합니다 - 설정되어 있지 않은 경우에만
add_pythonpath_if_not_exists() {
    if ! grep -qFx "export PYTHONPATH=\"/home/\$USER/openpilot/.venv/bin/python3:/home/\$USER/openpilot\"" "$bashrc_file"; then
        echo "$bashrc_file에 PYTHONPATH 추가 중"
        echo "export PYTHONPATH=\"/home/\$USER/openpilot/.venv/bin/python3:/home/\$USER/openpilot\"" >> "$bashrc_file"
    else
        echo "$bashrc_file에 이미 PYTHONPATH가 설정되어 있습니다. 스킵합니다."
    fi
}

# DISPLAY 및 관련 설정을 .bashrc에 추가합니다 - 설정되어 있지 않은 경우에만
add_display_settings_if_not_exists() {
    if ! grep -qFx "export DISPLAY=\"\$(grep nameserver /etc/resolv.conf | sed 's/nameserver //'):0\"" "$bashrc_file"; then
        echo "$bashrc_file에 DISPLAY 설정 추가 중"
        echo "export DISPLAY=\"\$(grep nameserver /etc/resolv.conf | sed 's/nameserver //'):0\"" >> "$bashrc_file"
        echo "export LIBGL_ALWAYS_INDIRECT=1" >> "$bashrc_file"
        echo "export DISPLAY=\$WSL_IF_IP:0" >> "$bashrc_file"
        echo "unset LIBGL_ALWAYS_INDIRECT" >> "$bashrc_file"
    else
        echo "$bashrc_file에 이미 DISPLAY 설정이 존재합니다. 스킵합니다."
    fi
}

# Alias를 추가합니다 (존재하지 않는 경우)
## 커스텀명령어 - Plotjuggler 실행. 
add_alias_if_not_exists "op_plot" "cd ~/openpilot/tools/plotjuggler && ./juggle.py --stream"
## 커스텀명령어 -  PC용 오픈파일럿 셋업
add_alias_if_not_exists "op_pc_set" "cd ~/tools/op_pc_installer && ./installer.sh"
## 커스텀명령어 -  PC용 오픈파일럿 실행
add_alias_if_not_exists "op_pc" "cd ~/tools/op_pc_installer && ./launch.sh"
echo
echo
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

