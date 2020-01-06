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

xout() {
  xclip -out -selection primary | xclip -in -selection clipboard
}

xin() {
  xclip -out -selection clipboard | xclip -in -selection primary
}

xls() {
  for b in primary secondary clipboard; do
    echo -n "$b ";
    xclip -out -selection $b;
    echo;
  done
}

mount_shared() {
  local name=${1:-shared}
  mkdir --parents ${HOME}/${name}
  # https://communities.vmware.com/thread/577218
  sudo vmhgfs-fuse -o nonempty -o allow_other .host:/${name} ${HOME}/${name}
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
