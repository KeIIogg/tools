#!/usr/bin/bash
# build openpilot & install plotjuggler
cd ~/openpilot && scons -u -j$(nproc) ; 
cd ~/openpilot/tools/plotjuggler ; 
./juggle.py --install ;
