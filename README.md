# plotjuggler
Install plotjuggler in wsl(windows)

# Install  (in ubuntu)
excute installer command in ubuntu 20.04

git clone -n --depth=1 --filter=tree:0 https://github.com/seonghoonko/plotjuggler.git && cd ~/plotjuggler && git sparse-checkout set --no-cone installer && git checkout && cd ~/plotjuggler/installer && chmod +x 1_installer.sh ; chmod +x 2_installer.sh ; ./1_installer.sh ; ./2_installer.sh 

# Execute 

op_plot

# Environment

Openpilot is worked for ubuntu 20.04
for openpilot debugging, WSL2(windows)
