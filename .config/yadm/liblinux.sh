install-python() {
    local PYTHON_VERSION=${1}
    pyenv install ${PYTHON_VERSION}
    pyenv global ${PYTHON_VERSION}
    eval "$(pyenv init --path)"
    pip install --upgrade pip
}

install-vim-plugins() {
    if [ ! -e ~/.vim/plug/autoload/plug.vim ]; then
      mkdir --parents ~/.vim/plug
      git clone --depth 1 https://github.com/junegunn/vim-plug ~/.vim/plug/autoload
      env --unset GIT_DIR vim '+PlugUpdate' '+PlugClean!' '+PlugUpdate' '+qall'
    fi
}

generate-ssh-key() {
    if [ ! -e ~/.ssh/id_ed25519 ]; then
      # Create an SSH key for this machine. Never copy the private half anywhere.
      ssh-keygen -t ed25519 -C "$(whoami)@$(hostname)"
      eval "$(ssh-agent -s)"
      ssh-add ~/.ssh/id_ed25519
    fi
}

configure-yadm() {
    # Aliases have no effect in scripts.
    local yadm="${HOME}/.yadm.git/yadm"
    "${yadm}" remote set-url origin git@github.com:thejohnfreeman/dotfiles.git
}
