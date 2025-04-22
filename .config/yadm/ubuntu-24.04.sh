#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

# Parameters.
CLANG_VERSION='18'
NODE_VERSION='22'
PYTHON_VERSION='3.12'

source libubuntu.sh

# Install packages.
# KitWare makes CMake, but their PPA only publishes for LTS releases.
sudo add-apt-repository --yes ppa:neovim-ppa/unstable
sudo apt update
sudo apt install --yes apt-transport-https
packages=(
  cmake
  curl
  docker.io
  entr
  git
  jq
  kitty
  libssl-dev
  neovim
  ninja-build
  pipx
  silversearcher-ag
  tmux
  tree
  tree-sitter-cli
  xclip
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

# Add u2f rules.
# https://docs.01.org/clearlinux/latest/tutorials/yubikey-u2f.html
if [ ! -e /etc/udev/rules.d/70-u2f.rules ]; then
  curl -O https://raw.githubusercontent.com/Yubico/libu2f-host/master/70-u2f.rules
  sudo mv 70-u2f.rules /etc/udev/rules.d/
  sudo udevadm control --reload-rules && sudo udevadm trigger
fi

# Install dependencies for Dropbox.
sudo apt install --yes libcairo2-dev libgirepository1.0-dev libgpgme-dev swig
pip install pycairo pygobject gpg
# https://www.dropbox.com/install-linux

# Restart.
