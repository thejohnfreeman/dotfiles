# Install packages
# https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
# https://yarnpkg.com/lang/en/docs/install/#debian-stable
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
# KitWare makes CMake.
# https://apt.kitware.com/
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | sudo apt-key add -
sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main'

sudo apt install apt-transport-https
sudo apt update
sudo apt install curl entr tmux git nodejs neovim yarn tree \
  silversearcher-ag jq libssl-dev cmake zlib-dev

sudo apt install clang-8 clang-format-8
sudo update-alternatives \
  --install /usr/bin/clang clang /usr/bin/clang-8 100 \
  --slave /usr/bin/clang++ clang++ /usr/bin/clang++-8
sudo update-alternatives \
  --install /usr/bin/clang-format clang-format /usr/bin/clang-format-8 100 \
  --slave /usr/bin/clang-format-diff clang-format-diff /usr/bin/clang-format-diff-8

# https://github.com/pyenv/pyenv-installer
curl https://pyenv.run | bash
# https://github.com/pyenv/pyenv/wiki/Common-build-problems
sudo apt-get install make build-essential libssl-dev zlib1g-dev libbz2-dev \
  libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
  libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl
pyenv install 3.7.1
pyenv global 3.7.1

# Install vim plugins
curl --fail --location --output ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qa

sudo apt install libcairo2-dev libgirepository1.0-dev libpgpme-dev
pip install pycairo
pip install pygobject
pip install gpg
sudo apt install dropbox
dropbox update
dropbox start

# Restart
