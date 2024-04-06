git remote set-url origin git@github.com:thejohnfreeman/dotfiles.git

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
# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
packages+=(
  base-devel
  openssl
  tk
  xz
  zlib
)
sudo pamac upgrade
sudo pamac install ${packages[@]}

sudo systemctl start pcscd.service

source install.linux.sh
