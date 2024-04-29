#!/usr/bin/bash
#add .bashrc for qt (network connection)
sed -i'' -r -e "$You may want to put all your additions into a separate file like$i\alias op_plot='cd ~/openpilot/tools/plotjuggler&&./juggle.py --stream'$" ~/.bashrc;
