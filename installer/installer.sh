#!/usr/bin/bash
mv ~/.bashrc ~/.bashrc.bak;
mv ~/plotjuggler/installer/.bashrc ~/.bashrc;
cd ~;
sudo apt update ; 
upgrade ; 
sudo apt install x11-apps -y ;
sudo apt install python3-pip ;
curl https://bootstrap.pypa.io/get\-pip.py \-o get\-pip.py ; 
python3 get-pip.py ; pip3 install pip --upgrade ; 
sudo pip install --ignore-installed poetry ; 
sudo apt install python3-testresources ;  
poetry init –n ; pip3 install numpy ;  
sudo apt install scons ; 
pip3 install  scons ; 
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash ; 
sudo apt-get update ; 
sudo apt install git-lfs; 
cd ~ ; 
git clone --recurse-submodules https://github.com/commaai/openpilot.git ;
cd ~/openpilot ; git lfs pull ; 
export PYTHONPATH="/home/$USER/openpilot/.venv/bin/python3:/home/$USER/openpilot";
export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0";
export LIBGL_ALWAYS_INDIRECT=1;
export DISPLAY=$WSL_IF_IP:0;
unset LIBGL_ALWAYS_INDIRECT;
cd ~/openpilot&&tools/ubuntu_setup.sh ; 
cd ~/openpilot&&poetry shell ; 

# build openpilot 
cd ~/openpilot;
scons -u -j$(nproc) ; 

# install plotjuggler
cd ~/openpilot/tools/plotjuggler ; 
./juggle.py --install ;
