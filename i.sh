#!/bin/bash -e
cd ~; 
git clone https://github.com/seonghoonko/plotjuggler.git;
cd ~/plotjuggler/installer; 
chmod +x installer.sh; 
./installer.sh;