# docker-build-run
# https://jfreeman.dev/blog/2020/02/10/how-to-initialize-a-docker-container-without-building-an-image/
# Start an interactive shell in a container initialized from a script.
dbr() {
  image="${1:-ubuntu:xenial}"
  script="${2:-entrypoint.sh}"
  sudo docker run --rm --interactive --tty --volume "$PWD:/entrypoint" \
    --entrypoint "/entrypoint/${script}" "${image}"
}

# github-pages
ghpages() {
  origin="git@github.com:thejohnfreeman/rippled.git"
  echo -n "origin? [${origin}] "
  read answer
  origin="${answer:-${origin}}"
  git init
  git remote add origin "${origin}"
  git fetch --depth 1 origin gh-pages
  git reset --soft origin/gh-pages
  git add .
  git commit
  git push origin master:gh-pages
}

split() {
  tr "${1:-:}" "\n"
}

# throw-away-directory
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
alias cupcake='~/code/cupcake/.venv/bin/cupcake'
