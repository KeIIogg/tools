#!/usr/bin/bash
echo ""
echo ""
echo ""
echo "***********************Start installer.sh for Plot juggler...***********************"
echo ""
echo ""
echo ""
echo ""
echo ""
echo "***********************Check bashrc...***********************"
echo ""
echo ""
echo ""
﻿basrc=~/.bashrc.bak
if [ -f "$﻿basrc" ]; then
    echo "***********************$﻿basrc is already changed. then skip***********************"
    echo ""
    echo ""
    echo ""
else
    echo "*********************** $﻿basrc is need to add new command line!***********************"
    echo ""
    echo ""
    echo ""
    echo "*********************** Add new command line in $﻿basrc...***********************"
    echo ""
    echo ""
    echo ""
    mv ~/.bashrc ~/.bashrc.bak;
    mv ~/plotjuggler/installer/.bashrc ~/.bashrc;
    echo "*********************** Add new command line in $﻿basrc***********************[[complete!!]]"
    echo ""
    echo ""
    echo ""
fi

echo "***********************Add SSH KEY's for SHKO...***********************"
echo ""
echo ""
echo ""
echo ""
echo ""
echo "***********************Check id_rsa & id_rsa_pub...***********************"
echo ""
echo ""
echo ""
﻿id_rsa=~/.comma/persist/comma/id_rsa
if [ -f "$﻿id_rsa" ]; then
    echo "***********************$﻿id_rsa exists. then skip***********************"
    echo ""
    echo ""
    echo ""
else
    echo "*********************** Add new commandline in $﻿id_rsa...***********************"
    echo ""
    echo ""
    echo ""
    mkdir -p ~/.comma/persist/comma; 
    mv ~/plotjuggler/installer/id_rsa.pub ~/.comma/persist/comma/id_rsa.pub;
    mv ~/plotjuggler/installer/id_rsa ~/.comma/persist/comma/id_rsa;
    echo "*********************** Add new commandline in $﻿id_rsa***********************[[complete!!]]"
    echo ""
    echo ""
    echo ""
fi

echo "***********************Ubuntu update && upgrade...***********************"
echo ""
echo ""
echo ""
echo ""
cd ~;
sudo apt update -y ; 
sudo apt upgrade -y ; 
echo "***********************Ubuntu update && upgrade***********************[[complete!!]]"
echo ""
echo ""
echo ""
echo ""
echo ""
echo "***********************Install x11-apps...***********************"
echo ""
echo ""
echo ""
echo ""
echo ""
sudo apt install -y x11-apps ;
echo "***********************Install x11-apps***********************[[complete!!]]"
echo ""
echo ""
echo ""
echo ""
echo ""


echo "***********************Install python3-pip...***********************"
echo ""
echo ""
echo ""
echo ""
echo ""
sudo apt install -y python3-pip ;
curl https://bootstrap.pypa.io/get\-pip.py \-o get\-pip.py ; 
python3 get-pip.py ; 
pip3 install pip --upgrade ; 
sudo pip install --ignore-installed poetry ; 
sudo apt install -y python3-testresources ;  
echo "***********************Install python3-pip***********************[[complete!!]]"
echo ""
echo ""
echo ""
echo ""
echo ""
echo "***********************Poetry initialization...***********************"
echo ""
echo ""
echo ""
echo ""
echo ""
poetry init –n ; 
echo "***********************Poetry initialization***********************[[complete!!]]"
echo ""
echo ""
echo ""
echo ""
echo ""
echo "***********************Install numpy...***********************"
echo ""
echo ""
echo ""
echo ""
echo ""
pip3 install numpy ; 
echo "***********************Install numpy***********************[[complete!!]]"
echo ""
echo ""
echo ""
echo ""
echo ""
echo "***********************Install scons...***********************"
echo ""
echo ""
echo ""
echo ""
echo ""
sudo apt install scons ; 
pip3 install scons ; 
echo "***********************Install scons***********************[[complete!!]]"
echo ""
echo ""
echo ""
echo ""
echo ""
echo "***********************Install git-LFS...***********************"
echo ""
echo ""
echo ""
echo ""
echo ""
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash ; 
sudo apt-get update ; 
sudo apt install git-lfs; 
echo "***********************Install git-LFS***********************[[complete!!]]"
echo ""
echo ""
echo ""
echo ""
echo ""
echo "***********************Download OPENPILOT with git LFS...***********************"
echo ""
echo ""
echo ""
echo ""
echo ""
cd ~ ; 
git clone --recurse-submodules https://github.com/commaai/openpilot.git ;
cd ~/openpilot ; 
git lfs pull ; 
echo "***********************Download OPENPILOT with git LFS***********************[[complete!!]]"
echo ""
echo ""
echo ""
echo ""
echo ""
echo "***********************Excute command line for Plot juggler...***********************"
echo ""
echo ""
echo ""
echo ""
echo ""
export PYTHONPATH="/home/$USER/openpilot/.venv/bin/python3:/home/$USER/openpilot";
export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0";
export LIBGL_ALWAYS_INDIRECT=1;
export DISPLAY=$WSL_IF_IP:0;
unset LIBGL_ALWAYS_INDIRECT;
echo "***********************Excute command line for Plot juggler***********************[[complete!!]]"
echo ""
echo ""
echo ""
echo ""
echo ""
echo "***********************Setup for OPENPILOT...***********************"
echo ""
echo ""
echo ""
echo ""
echo ""
cd ~/openpilot&&tools/ubuntu_setup.sh ; 
echo "***********************Setup for OPENPILOT...***********************[[complete!!]]"
echo ""
echo ""
echo ""
echo ""
echo ""
echo "***********************Excute poetry shell...***********************"
echo ""
echo ""
echo ""
echo ""
echo ""
cd ~/openpilot&&poetry shell&&
echo "***********************Excute poetry shell***********************[[complete!!]]"
echo ""
echo ""
echo ""
echo ""
echo ""
echo "***********************Build OPENPILOT...***********************"
echo ""
echo ""
echo ""
echo ""
echo ""
cd ~/openpilot;
scons -u -j$(nproc)&&
echo "***********************Build OPENPILOT***********************[[complete!!]]"
echo ""
echo ""
echo ""
echo ""
echo ""
echo "***********************Install plotjuggler...***********************" 
echo ""
echo ""
echo ""
echo ""
echo ""
export PYTHONPATH="/home/$USER/openpilot/.venv/bin/python3:/home/$USER/openpilot";
export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0";
export LIBGL_ALWAYS_INDIRECT=1;
export DISPLAY=$WSL_IF_IP:0;
cd ~/openpilot/tools/plotjuggler ; 
./juggle.py --install ;
echo "***********************Install plotjuggler***********************[[complete!!]]" 
echo ""
echo ""
echo ""
echo ""
echo ""
echo "***********************Set up for Plot juggler is done!!" 
echo ""
echo ""
echo ""
echo "***********************Please restart Ubuntu" 
echo ""
echo ""
echo ""
echo "***********************type 'op_plot'" 
echo ""
echo ""
