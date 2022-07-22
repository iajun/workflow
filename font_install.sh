git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts 
cd nerd-fonts
git sparse-checkout add patched-fonts/Meslo 
./install.sh Meslo 
