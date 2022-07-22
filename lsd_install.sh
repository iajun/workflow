wget https://github.com/Peltoche/lsd/releases/download/0.22.0/lsd_0.22.0_amd64.deb
dpkg -i lsd_0.22.0_amd64.deb
rm lsd_0.22.0_amd64.deb
apt install lsd -y

echo "alias ls=lsd" >> ~/.bashrc
