source liblinux.sh

install-node() {
    local NODE_VERSION=${1}
    # https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions
    if ! command -v node; then
        curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | sudo -E bash
        sudo apt install --yes nodejs
    fi
}

install-clang() {
    local v=${1}
    for exe in clang-${v} clang-format-${v} clangd-${v}; do
        if ! command -v ${exe}; then
          sudo apt install --yes ${exe}
        fi
    done
    if ! command -v clang; then
      sudo update-alternatives \
        --install /usr/bin/clang clang /usr/bin/clang-${v} 100 \
        --slave /usr/bin/clang++ clang++ /usr/bin/clang++-${v}
    fi
    if ! command -v clang-format; then
      sudo update-alternatives \
        --install /usr/bin/clang-format clang-format /usr/bin/clang-format-${v} 100 \
        --slave /usr/bin/clang-format-diff clang-format-diff /usr/bin/clang-format-diff-${v} \
        --slave /usr/bin/git-clang-format git-clang-format /usr/bin/git-clang-format-${v}
    fi
    if ! command -v clangd; then
      sudo update-alternatives \
        --install /usr/bin/clangd clangd /usr/bin/clangd-${v} 100
    fi
}

install-pyenv() {
    # https://github.com/pyenv/pyenv-installer
    if ! command -v pyenv; then
      curl https://pyenv.run | bash
    fi
    # https://github.com/pyenv/pyenv/wiki#suggested-build-environment
    # I have not tested this set of dependencies for Python versions <3.12.
    sudo apt install --yes build-essential libssl-dev zlib1g-dev libbz2-dev \
      libreadline-dev libsqlite3-dev libncursesw5-dev \
      xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
}

install-poetry() {
    # https://python-poetry.org/docs/#installation
    if ! command -v poetry; then
      curl -sSL https://install.python-poetry.org | python3 -
    fi
}
