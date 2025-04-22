#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

# Parameters.
CLANG_VERSION='19'
NODE_VERSION='23'
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
  openssh-server
  pipx
  ripgrep
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

# Restart.
