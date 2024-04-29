#!/usr/bin/bash
#add .bashrc for qt (network connection)
cd ~;
sed '98 i\
#Custom alias
alias op_plot='cd ~/openpilot/tools/plotjuggler&&./juggle.py --stream’' .bashrc;
sed '$s/$/\n
export PYTHONPATH="/home/$USER/openpilot/.venv/bin/python3:/home/$USER
/openpilot"
export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"
export LIBGL_ALWAYS_INDIRECT=1
export DISPLAY=$WSL_IF_IP:0
unset LIBGL_ALWAYS_INDIRECT
/g' .bashrc;

