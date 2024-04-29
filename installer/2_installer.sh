#!/usr/bin/bash
# build openpilot & install plotjuggler
scons -u -j$(nproc) ; 
cd ~/openpilot/tools/plotjuggler ; 
./juggle.py --install


