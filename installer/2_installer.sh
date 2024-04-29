#!/usr/bin/bash
#add .bashrc for qt (network connection)

cd /etc/;
sudo su - root;
chmod +x bash.bashrc;
chmod +w bash.bashrc;

sed '98 i\
alias op_plot='cd ~/openpilot/tools/plotjuggler&&./juggle.py --stream'' bash.bashrsc;

sed '$s/$/\n
export PYTHONPATH="/home/$USER/openpilot/.venv/bin/python3:/home/$USER
/openpilot"
export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"
export LIBGL_ALWAYS_INDIRECT=1
export DISPLAY=$WSL_IF_IP:0
unset LIBGL_ALWAYS_INDIRECT
/g' bash.bashrsc;

