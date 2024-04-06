# Install packages.
packages=(
  clang
  cmake
  curl
  docker
  entr
  git
  jq
  kitty
  make
  neovim
  ninja
  nodejs
  npm
  pyenv
  ripgrep
  tmux
  tree
  xclip
)
sudo pacman -Syu ${packages[@]}

sudo systemctl start pcscd.service

# Install Vim plugins.
curl --fail --location --output ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln --symbolic $HOME/.vim $HOME/.config/nvim
nvim -u .vimrc +PlugInstall +qa

# Install Python.
# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
sudo packman -Syu --needed base-devel openssl zlib xz tk
pyenv install 3.12
pyenv global 3.12
eval "$(pyenv init --path)"
pip install --upgrade pip

pip install poetry 'conan<2'

# Create an SSH key for this machine. Never copy the private half anywhere.
ssh-keygen -t rsa -b 4096 -C "$(whoami)@$(hostname)"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
