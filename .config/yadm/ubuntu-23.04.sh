#!/bin/bash

# Parameters.
CLANG_VERSION=10
NODE_VERSION=20

# Install packages.
# KitWare makes CMake, but their PPA only publishes for LTS releases.
sudo apt update
sudo apt install --yes apt-transport-https
packages=(
  cmake
  curl
  entr
  git
  jq
  libssl-dev
  neovim
  silversearcher-ag
  telegram-desktop
  tmux
  tree
)
sudo apt install --yes ${packages[@]}

# Install Node.
# https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions
if ! command -v node; then
  curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | sudo -E bash
  sudo apt install --yes nodejs
fi

# Install Vim plugins.
if [ ! -e ~/.vim/plug/autoload/plug.vim ]; then
  mkdir --parents ~/.vim/plug
  git clone --depth 1 https://github.com/junegunn/vim-plug ~/.vim/plug/autoload
  env --unset GIT_DIR vim '+PlugUpdate' '+PlugClean!' '+PlugUpdate' '+qall'
fi

# Install Clang.
v=${CLANG_VERSION}
if ! command -v clang-${v}; then
  sudo apt install --yes clang-${v} clang-format-${v} clangd-${v}
  sudo update-alternatives \
    --install /usr/bin/clang clang /usr/bin/clang-${v} 100 \
    --slave /usr/bin/clang++ clang++ /usr/bin/clang++-${v}
  sudo update-alternatives \
    --install /usr/bin/clang-format clang-format /usr/bin/clang-format-${v} 100 \
    --slave /usr/bin/clang-format-diff clang-format-diff /usr/bin/clang-format-diff-${v} \
    --slave /usr/bin/git-clang-format git-clang-format /usr/bin/git-clang-format-${v}
  sudo update-alternatives \
    --install /usr/bin/clangd clangd /usr/bin/clangd-${v} 100
fi

# Install Python.
# https://github.com/pyenv/pyenv-installer
if ! command -v pyenv; then
  curl https://pyenv.run | bash
fi

# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
sudo apt install --yes make build-essential libssl-dev zlib1g-dev libbz2-dev \
  libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
  libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl
pyenv install 3.7.1
pyenv global 3.7.1
pip install --upgrade pip

pip install conan

# https://python-poetry.org/docs/#installation
if ! command -v poetry; then
  curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
fi

# Install dependencies for Dropbox.
sudo apt install --yes libcairo2-dev libgirepository1.0-dev libgpgme-dev swig
pip install pycairo pygobject gpg
# https://www.dropbox.com/install-linux

if [ ! -e ~/.ssh/id_ed25519 ]; then
  # Create an SSH key for this machine. Never copy the private half anywhere.
  ssh-keygen -t ed25519 -C "$(whoami)@$(hostname)"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
fi

# Restart
