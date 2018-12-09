# This script only meant for Ubuntu 18.04 LTS.

# Install packages
# See http://askubuntu.com/a/548005/538768
sudo add-apt-repository ppa:ubuntu-mozilla-daily/firefox-aurora
# Unofficial Gradle PPA
sudo add-apt-repository ppa:cwchien/gradle

sudo apt-get install curl entr tmux git nodejs npm vim-gtk xclip tree yarn \
  silversearcher-ag stack openjdk-8-jdk gradle jq libssl-dev cmake

# https://docs.haskellstack.org/en/stable/install_and_upgrade/
curl -sSL https://get.haskellstack.org/ | sh

# Set up new ssh key for this host
ssh-keygen -t rsa -b 4096 -C "$(whoami)@$(hostname)"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

# Install dotfiles
(dir=$(mktemp --directory); \
    git clone https://github.com/thejohnfreeman/dotfiles.git --depth 1 --branch ubuntu $dir; \
    rsync --recursive $dir/files/ ~; \
    rm --recursive --force $dir)
echo 'source ~/.bashrc.addendum' >> ~/.bashrc

# Install vim plugins
curl --fail --location --output ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qa

# Install GHC and packages
stack setup
stack install ghc-mod hlint
stack install --resolver nightly hindent

# Restart
