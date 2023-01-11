# Variables
CONFIG_PATH=${PWD}/.config
NVIM_PATH=${CONFIG_PATH}/nvim
ZSH_PATH=${CONFIG_PATH}/zsh
ZSH_PLUGIN_PATH=${ZSH_PATH}/.oh-my-zsh/custom/plugins

export ZSH=${ZSH_PATH}/.oh-my-zsh;

# Install Homebrew
bash ./brew-install.sh;

# brew basics
if [ -d "${CONFIG_DIR}/.nvim" ]; then
  rm -rf "${CONFIG_DIR}/.nvim";
fi
mkdir "${CONFIG_DIR}/.nvim";
brew install nvm git python3 watchman rustup;

# Install Terminal
brew install --cask alacritty;

# Install Clipboard Management Tool
brew install --cask jumpcut

# Install zsh
rm -rf .config/zsh;
brew install zsh;
sh ./zsh-install.sh
rm ~/.zshrc;
cp .zshrc ${ZSH_PATH}
cp .zshenv ~

# Install zsh plugin manager
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
source "${ZSH_PATH}/.zshrc"
zinit self-update
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions

# Fonts
cd ./fonts;
sh ./install.sh;
cd ..;
cp fonts/ttf/*.ttf ${HOME}/Library/fonts;

# Install neovim
brew install neovim;

# Copy Configuration
CONFIG_DIR="${HOME}/.config"
if [ ! -d "${CONFIG_DIR}" ]; then
  mkdir ${CONFIG_DIR};
fi
rm -rf ${CONFIG_DIR}/{alacritty,nvim,tmux,zsh}
cp -r ${PWD}/.config/* ${CONFIG_DIR}

nvm install node;

# Config git
git config --global user.email "iveoname@gmail.com";
git config --global user.name "Sharp Zhou"
