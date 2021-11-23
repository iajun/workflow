# Variables
CONFIG_PATH=${PWD}/.config
NVIM_PATH=${CONFIG_PATH}/nvim
ZSH_PATH=${CONFIG_PATH}/zsh
ZSH_PLUGIN_PATH=${ZSH_PATH}/.oh-my-zsh/custom/plugins

curl -fLo "${NVIM_PATH}"/autoload/plug.vim -m 5 --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";

# Install Terminal
brew install --cask alacritty;

# Install zsh
brew install zsh;
ZSH=${ZSH_PATH} sh ./zsh-install.sh
rm ~/.zshrc;

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_PLUGIN_PATH}/zsh-syntax-highlighting --depth=1;

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_PLUGIN_PATH}/zsh-autosuggestions --depth=1;

git clone https://github.com/powerline/fonts.git --depth=1;
sh ./fonts/install.sh;
rm -rf fonts;

# Install neovim
brew install neovim;
