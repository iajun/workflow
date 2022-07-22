apt install zsh -y
./oh_my_zsh_install.sh

sed -e "s|robbyrussell|af-magic|" -i ~/.zshrc

echo "alias vim=nvim" >> ~/.zshrc
source ~/.zshrc


