# Install packages
# KitWare makes CMake, but their PPA only publishes for LTS releases.

sudo apt install apt-transport-https
sudo apt update
sudo apt install curl entr tmux git nodejs npm neovim tree \
  silversearcher-ag jq libssl-dev cmake ninja docker.io

# Install vim plugins
curl --fail --location --output ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qa

v=17
sudo apt install clang-${v} clang-format-${v} clangd-${v}
sudo update-alternatives \
  --install /usr/bin/clang clang /usr/bin/clang-${v} 100 \
  --slave /usr/bin/clang++ clang++ /usr/bin/clang++-${v}
sudo update-alternatives \
  --install /usr/bin/clang-format clang-format /usr/bin/clang-format-${v} 100 \
  --slave /usr/bin/clang-format-diff clang-format-diff /usr/bin/clang-format-diff-${v} \
  --slave /usr/bin/git-clang-format git-clang-format /usr/bin/git-clang-format-${v}
sudo update-alternatives \
  --install /usr/bin/clangd clangd /usr/bin/clangd-${v} 100

# https://github.com/pyenv/pyenv-installer
curl https://pyenv.run | bash
# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
sudo apt-get install make build-essential libssl-dev zlib1g-dev libbz2-dev \
  libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
  libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl
pyenv install 3.12
pyenv global 3.12
pip install --upgrade pip

pip install 'conan<2'

# https://python-poetry.org/docs/#installation
curl -sSL https://install.python-poetry.org | python3 -

# Install dependencies for Dropbox
sudo apt install libcairo2-dev libgirepository1.0-dev libgpgme-dev swig
pip install pycairo
pip install pygobject
pip install gpg
# https://www.dropbox.com/install-linux

# Restart
