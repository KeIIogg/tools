# 1. Install WSL2 (in windows 10)

- CMD or Powershell in Administrator authority
  
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

wsl --set-default-version 2

# 2. Download WSL pakage

https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi

# 3. Install vcxsrv for GUI   (refer to : https://psychoria.tistory.com/739)

https://sourceforge.net/projects/vcxsrv

![1](https://github.com/seonghoonko/plotjuggler/assets/68089983/8828b3bb-8fed-450e-b549-5b31fe0a42d6)

![2](https://github.com/seonghoonko/plotjuggler/assets/68089983/00d77df6-8f90-40bf-b464-c5dce0b3c07f)

![3](https://github.com/seonghoonko/plotjuggler/assets/68089983/fd15f628-1555-4b61-b104-5658958ae00b)

![4](https://github.com/seonghoonko/plotjuggler/assets/68089983/c969646e-4656-45f3-93e9-afa09d0a6fb0)

![5](https://github.com/seonghoonko/plotjuggler/assets/68089983/64149671-eac5-4f36-ad36-2ccd67569b6d)

![6](https://github.com/seonghoonko/plotjuggler/assets/68089983/f0ca426f-c7e8-4be8-95e3-1bbe44158b69)

 

# 4. Install Ubuntu
Choose install method [1] or [2]

# 4-[1]. Ubuntu 20.04 with wsl  

https://apps.microsoft.com/detail/9mttcl66cpxj?hl=en-us&gl=US

# 4-[2]. Ubuntu 20.04 with wsl(in CMD or Powershell)


wsl --unregister ubuntu 

wsl –-unregister Ubuntu-20.04

wsl --install -d Ubuntu-20.04

# 5. Install plotjuggler  (in ubuntu)


cd ~; git clone https://github.com/seonghoonko/plotjuggler.git ; 
cd ~/plotjuggler/installer ;
chmod +x installer.sh ; ./installer.sh ; 

# Execute (in ubuntu)

op_plot

