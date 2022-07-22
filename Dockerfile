FROM debian:latest

COPY ./sources.list /etc/apt/

RUN apt update \
 && apt install apt-transport-https ca-certificates -y \
 && sed -e 's|http|https|g' -i /etc/apt/sources.list \
 && apt update \
 && apt install git wget curl lsof net-tools iputils-ping gpg build-essential -y

COPY ./oh_my_zsh_install.sh /
RUN apt install zsh -y \
 && ./oh_my_zsh_install.sh \
 && sed -e "s|robbyrussell|af-magic|" -i ~/.zshrc

SHELL ["/usr/bin/zsh", "-c"]

RUN wget https://github.com/Peltoche/lsd/releases/download/0.22.0/lsd_0.22.0_amd64.deb \
 && dpkg -i lsd_0.22.0_amd64.deb \
 && rm lsd_0.22.0_amd64.deb \
 && apt install lsd -y \
 && echo "alias ls=lsd" >> ~/.zshrc


RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
 && chmod u+x nvim.appimage \
 && ./nvim.appimage --appimage-extract \
 && ln -s /squashfs-root/AppRun /usr/bin/vim
COPY ./nvim /root/.config/nvim

ENV NVM_DIR /root/.nvm
ENV NODE_VERSION 17

COPY nvm_install.sh /
RUN /nvm_install.sh \
 && echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"\n[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> ~/.zshrc \
 && . $NVM_DIR/nvm.sh \ 
 && nvm install $NODE_VERSION \
 && nvm alias default $NODE_VERSION \
 && nvm use default

WORKDIR /root
