#!/usr/bin/bash
cd ~; 
git clone -n --depth=1 --filter=tree:0 https://github.com/seonghoonko/tools.git && cd ~/tools && git sparse-checkout set --no-cone installer && git checkout;
cd ~/tools/Plot_installer;
chmod +x installer.sh; 
./installer.sh;
