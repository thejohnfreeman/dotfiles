split() {
  tr "${1:-:}" "\n"
}

tad() {
  local ts=$(date +%s)
  local d="$HOME/.throw-away/$ts"
  mkdir -p $d
  (cd $d; $SHELL)
  rm -rf $d
}

xcp() {
  xclip -out -selection primary | xclip -in -selection clipboard
}

mount_shared() {
  # https://communities.vmware.com/thread/577218
  sudo vmhgfs-fuse -o nonempty -o allow_other .host:/shared $HOME/shared
}

watch() {
  while true; do
    git ls-files | entr -d "$@"
  done
}

alias config='git --git-dir=$HOME/.files --work-tree=$HOME'
alias l='ls -F --color=auto'
alias la='ls -AF --color=auto'
alias ll='ls -Fhl --color=auto --time-style=+%Y-%m-%d\ %H:%M:%S'
alias tree='tree -I "$(paste -d\| -s ~/.treeignore)"'
alias vim='nvim'
