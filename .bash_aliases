tad() {
  local ts=$(date +%s)
  local d="$HOME/.throw-away/$ts"
  mkdir -p $d
  (cd $d; $SHELL)
  rm -rf $d
}

watch() {
  while true; do
    git ls-files | entr -d "$@"
  done
}

alias config='git --git-dir=$HOME/.files --work-tree=$HOME'
alias l='ls -FG'
alias la='ls -AFG'
alias ll='ls -FGhl'
alias tree='tree -I "$(paste -d\| -s ~/.treeignore)"'
