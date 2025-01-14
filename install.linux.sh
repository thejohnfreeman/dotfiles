#!/bin/sh

set -o errexit
set -o nounset
set -o pipefail

source "${HOME}/.aliases"

# Install Vim plugins.
curl --fail --location --output ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qa

# Install Python.
pyenv install 3.12
pyenv global 3.12
eval "$(pyenv init --path)"
pip install --upgrade pip

pip install poetry 'conan<2'

# Create an SSH key for this machine. Never copy the private half anywhere.
ssh-keygen -t ed25519 -C "$(whoami)@$(hostname)"
eval "$(ssh-agent -s)"
ssh-add "${HOME}/.ssh/id_ed25519"

echo "source ~/.every.sh" >> ~/.zshrc
