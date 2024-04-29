#!/usr/bin/bash
# build openpilot 
cd ~/openpilot && scons -u -j$(nproc) ; 

