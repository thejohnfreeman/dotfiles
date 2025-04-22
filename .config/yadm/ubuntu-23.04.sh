#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

# Parameters.
CLANG_VERSION='10'
NODE_VERSION='20'
PYTHON_VERSION='3.7.1'

source libubuntu.sh

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
  pipx
  silversearcher-ag
  telegram-desktop
  tmux
  tree
)
sudo apt install --yes ${packages[@]}

install-node ${NODE_VERSION}
install-clang ${CLANG_VERSION}
install-pyenv
install-python ${PYTHON_VERSION}
pipx install poetry conan
install-vim-plugins
generate-ssh-key
configure-yadm

# Install dependencies for Dropbox.
sudo apt install --yes libcairo2-dev libgirepository1.0-dev libgpgme-dev swig
pip install pycairo pygobject gpg
# https://www.dropbox.com/install-linux

# Restart.
