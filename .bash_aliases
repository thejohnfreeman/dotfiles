tad() {
  local ts=$(date +%s)
  local d="$HOME/.throw-away/$ts"
  mkdir -p $d
  (cd $d; $SHELL)
  rm -rf $d
}

mount_shared() {
  sudo mount --types vboxsf shared ~/shared
}

watch() {
  while true; do
    git ls-files | entr -d "$@"
  done
}

alias config='git --git-dir=$HOME/.files --work-tree=$HOME'
alias l='ls -F --color=auto'
alias la='ls -AF --color=auto'
alias ll='ls -Fhl --color=auto'
alias tree='tree -I "$(paste -d\| -s ~/.treeignore)"'
