#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

# Install packages.
# KitWare makes CMake, but their PPA only publishes for LTS releases.
sudo apt update
sudo apt install --yes apt-transport-https
packages=(
  clang
  clangd
  clang-format
  cmake
  curl
  entr
  git
  jq
  kitty
  libssl-dev
  neovim
  ninja-build
  openssh-server
  ripgrep
  tmux
  tree
  tree-sitter-cli
  xclip
  unzip
)
sudo apt install --yes ${packages[@]}

# bun
if ! command -v bun; then
  curl -fsSL https://bun.com/install | bash
fi

# python3
if ! command -v python3; then
  uv python install
fi

# conan
if ! command -v conan; then
  uv tool install conan
fi

# cupcake
if ! command -v cupcake; then
  uv tool install cupcake
fi

# Install Vim plugins.
if [ ! -e ~/.vim/plug/autoload/plug.vim ]; then
  mkdir --parents ~/.vim/plug
  git clone --depth 1 https://github.com/junegunn/vim-plug ~/.vim/plug/autoload
  env --unset GIT_DIR vim '+PlugUpdate' '+PlugClean!' '+PlugUpdate' '+qall'
fi

# Generate SSH key.
if [ ! -e ~/.ssh/id_ed25519 ]; then
  # Create an SSH key for this machine. Never copy the private half anywhere.
  ssh-keygen -t ed25519 -C "$(whoami)@$(hostname)"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
fi

yadm="${HOME}/.yadm.git/yadm"
"${yadm}" remote set-url origin git@github.com:thejohnfreeman/dotfiles.git

echo "Please restart."
