# install macports first please!

# Variables
CONFIG_PATH=${PWD}/.config
NVIM_PATH=${CONFIG_PATH}/nvim
ZSH_PATH=${CONFIG_PATH}/zsh
ZSH_PLUGIN_PATH=${ZSH_PATH}/.oh-my-zsh/custom/plugins

export ZSH=${ZSH_PATH}/.oh-my-zsh;

# brew basics
if [ -d "${CONFIG_DIR}/.nvim" ]; then
  rm -rf "${CONFIG_DIR}/.nvim";
fi
mkdir "${CONFIG_DIR}/.nvim";
port install neovim tmux tmux-pasteboard autojump ripgrep nvim zsh stylua;

# Install zsh
rm -rf .config/zsh;
sh ./zsh-install.sh
rm ~/.zshrc;
cp .zshrc ${ZSH_PATH}
cp .zshenv ~

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_PLUGIN_PATH}/zsh-syntax-highlighting --depth=1;

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_PLUGIN_PATH}/zsh-autosuggestions --depth=1;

# Fonts
cd ./fonts;
sh ./install.sh;
cd ..;
cp fonts/ttf/*.ttf ${HOME}/Library/fonts;

# Copy Configuration
CONFIG_DIR="${HOME}/.config"
if [ ! -d "${CONFIG_DIR}" ]; then
  mkdir ${CONFIG_DIR};
fi
rm -rf ${CONFIG_DIR}/{alacritty,nvim,tmux,zsh}
cp -r ${PWD}/.config/* ${CONFIG_DIR}

nvm install node;

npm i -g eslint_d @fsouza/prettierd typescript yarn;
