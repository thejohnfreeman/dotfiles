install-python() {
    local PYTHON_VERSION=${1}
    pyenv install ${PYTHON_VERSION}
    pyenv global ${PYTHON_VERSION}
    eval "$(pyenv init --path)"
    pip install --upgrade pip
}

install-vim-plugins() {
    [ -e ~/.vim/plug/autoload/plug.vim ] || git clone --depth 1 https://github.com/junegunn/vim-plug ~/.vim/plug/autoload
    env --unset GIT_DIR nvim '+PlugUpdate' '+PlugClean!' '+PlugUpdate' '+qall'
}

generate-ssh-key() {
    # Generate an SSH key for this machine. Never copy the private half anywhere.
    [ -e ~/.ssh/id_ed25519 ] || ssh-keygen -t ed25519 -C "$(whoami)@$(hostname)"
    [ -z "${SSH_AUTH_SOCK:-}" ] || ssh-add -T ~/.ssh/id_ed25519.pub 2>/dev/null || ssh-add ~/.ssh/id_ed25519
}

configure-yadm() {
    # Aliases have no effect in scripts.
    local yadm="${HOME}/.yadm.git/yadm"
    "${yadm}" remote set-url origin git@github.com:thejohnfreeman/dotfiles.git
}
