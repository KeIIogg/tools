#!/usr/bin/bash
# build openpilot 
cd ~/openpilot;
scons -u -j$(nproc) ; 

# install plotjuggler
cd ~/openpilot/tools/plotjuggler ; 
./juggle.py --install ;
