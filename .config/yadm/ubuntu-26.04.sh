#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

source liblinux.sh

export PATH="$HOME/.local/bin:$HOME/.bun/bin:$PATH"

# Install packages.
sudo apt update
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
  podman
  ripgrep
  tmux
  tree
  tree-sitter-cli
  xclip
  unzip
)
sudo apt install --yes "${packages[@]}"

command -v bun >/dev/null || curl -fsSL https://bun.com/install | bash
command -v uv >/dev/null || curl -fsSL https://astral.sh/uv/install.sh | sh

uv python install
uv tool install conan
uv tool install cupcake

install-vim-plugins
generate-ssh-key
configure-yadm

echo "Please restart."
