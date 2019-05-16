# This script only meant for Ubuntu 18.04 LTS.

# Install packages
# See http://askubuntu.com/a/548005/538768
sudo add-apt-repository ppa:ubuntu-mozilla-daily/firefox-aurora
# Unofficial Gradle PPA
sudo add-apt-repository ppa:cwchien/gradle
# https://github.com/nodesource/distributions/blob/master/README.md
curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
# https://yarnpkg.com/lang/en/docs/install/#debian-stable
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
# https://code.visualstudio.com/docs/setup/linux
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
# https://apt.kitware.com/
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | sudo apt-key add -
sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main'

sudo apt install apt-transport-https
sudo apt update
sudo apt install code curl entr tmux git nodejs vim-gtk xclip yarn tree \
  silversearcher-ag stack openjdk-8-jdk gradle jq libssl-dev cmake firefox \
  zlib-dev

# https://github.com/pyenv/pyenv-installer
curl https://pyenv.run | bash
# https://github.com/pyenv/pyenv/wiki/Common-build-problems
sudo apt-get install make build-essential libssl-dev zlib1g-dev libbz2-dev \
  libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
  libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl
pyenv install 3.7.1
pyenv global 3.7.1

# https://docs.haskellstack.org/en/stable/install_and_upgrade/
curl -sSL https://get.haskellstack.org/ | sh

# Set up new ssh key for this host
ssh-keygen -t rsa -b 4096 -C "$(whoami)@$(hostname)"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
# Copy for GitHub.
xclip -i ~/.ssh/id_rsa.pub

# Install vim plugins
curl --fail --location --output ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qa

# Install GHC and packages
stack setup
stack install ghc-mod hlint
stack install --resolver nightly hindent

# Restart
