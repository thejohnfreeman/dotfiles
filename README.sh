# Install packages
# https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
# https://yarnpkg.com/lang/en/docs/install/#debian-stable
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
# KitWare makes CMake, but their PPA only publishes for LTS releases.

sudo apt install apt-transport-https
sudo apt update
sudo apt install curl entr tmux git nodejs neovim yarn tree \
  silversearcher-ag jq libssl-dev cmake nordvpn wireguard

# Configure VPN
nordvpn set technology NordLynx

# Install vim plugins
curl --fail --location --output ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qa

v=10
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
# https://github.com/pyenv/pyenv/wiki/Common-build-problems
sudo apt-get install make build-essential libssl-dev zlib1g-dev libbz2-dev \
  libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
  libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl
pyenv install 3.7.1
pyenv global 3.7.1
pip install --upgrade pip

# https://python-poetry.org/docs/#installation
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python

# Install dependencies for Dropbox
sudo apt install libcairo2-dev libgirepository1.0-dev libgpgme-dev swig
pip install pycairo
pip install pygobject
pip install gpg
# https://www.dropbox.com/install-linux

# Restart
