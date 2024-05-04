#!/bin/bash -e
cd ~; 
git clone -n --depth=1 --filter=tree:0 https://github.com/seonghoonko/plotjuggler.git && cd ~/plotjuggler && git sparse-checkout set --no-cone installer && git checkout;
cd ~/plotjuggler/installer;
chmod +x installer.sh; 
./installer.sh;
