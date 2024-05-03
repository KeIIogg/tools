#!/usr/bin/bash
echo "Start installer for Plot juggler..."
echo "Change authority 'root'..."
su -

echo "Add command line for start up Plotjuggler..."
mv ~/.bashrc ~/.bashrc.bak;
mv ~/plotjuggler/installer/.bashrc ~/.bashrc;

echo "Add SSH KEY's..."
mkdir -p ~/.comma/persist/comma; 
mv ~/plotjuggler/installer/id_rsa.pub ~/.comma/persist/comma/id_rsa.pub;
mv ~/plotjuggler/installer/id_rsa ~/.comma/persist/comma/id_rsa;

echo "Ubuntu update && upgrade..."
cd ~;
sudo apt update -y ; 
sudo apt upgrade -y ; 

echo "Install x11-apps..."
sudo apt install -y x11-apps ;

echo "Install python3-pip..."
sudo apt install -y python3-pip ;
curl https://bootstrap.pypa.io/get\-pip.py \-o get\-pip.py ; 
python3 get-pip.py ; 
pip3 install -y pip --upgrade ; 
sudo pip install -y --ignore-installed poetry ; 
sudo apt install -y python3-testresources ;  

echo "Poetry initialization..."
poetry init –n ; 

echo "Install numpy..."
pip3 install -y numpy ; 

echo "Install scons..."
sudo apt install -y scons ; 
pip3 install -y scons ; 

echo "Install git-LFS..."
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash ; 
sudo apt-get update -y ; 
sudo apt install -y git-lfs; 

echo "Download OPENPILOT with LFS..."
cd ~ ; 
git clone --recurse-submodules https://github.com/commaai/openpilot.git ;
cd ~/openpilot ; 
git lfs pull ; 

echo "Excute cmd line for plotjuggler..."
export PYTHONPATH="/home/$USER/openpilot/.venv/bin/python3:/home/$USER/openpilot";
export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0";
export LIBGL_ALWAYS_INDIRECT=1;
export DISPLAY=$WSL_IF_IP:0;
unset LIBGL_ALWAYS_INDIRECT;

echo "Setup for OPENPILOT..."
cd ~/openpilot&&tools/ubuntu_setup.sh ; 

echo "Excute poetry shell..."
cd ~/openpilot&&poetry shell&&

echo "Build OPENPILOT..."
cd ~/openpilot;
scons -u -j$(nproc)&&

echo "Install plotjuggler..." 
export PYTHONPATH="/home/$USER/openpilot/.venv/bin/python3:/home/$USER/openpilot";
export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0";
export LIBGL_ALWAYS_INDIRECT=1;
export DISPLAY=$WSL_IF_IP:0;
cd ~/openpilot/tools/plotjuggler ; 
./juggle.py --install ;

echo "Change authority USER..." 
su - $username

echo "Set up for Plot juggler is done" 
echo "Please restart Ubuntu" 
echo "type 'op_plot'" 
