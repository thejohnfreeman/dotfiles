# Terminal and iTerm2 execute `.profile` for each new window or tab, but not
# `.bashrc`. Similarly, tmux executes `.profile` for each new window or pane.
# `.bashrc` is only executed for an interactive subshell.

# `.bashrc` is executed many times in a chain of subshells. We don't want it
# to export any environment variables that it reads. At best, it re-exports
# the same value, which is effectively a no-op. At worst, it pads the same
# prefix onto `$PATH` which grows out-of-control.

# `.profile` is executed twice: once for the terminal emulator, once for tmux.
# Let's just wrap the environment variable exports with a guard. We could wrap
# the whole script with a guard, but this way lets us use it as a factory
# reset.

add_to_path() {
  if ! (echo "$PATH" | grep "$1" > /dev/null); then
    export PATH="$1:$PATH"
  fi
}

add_to_path "$HOME/.yarn/bin"
add_to_path "$HOME/.pyenv/bin"
add_to_path "$HOME/.local/bin"

# `test` returns true (0) if it is given a non-empty string.
# ${variable+value} returns `value` if `parameter` is set to anything.
if ! test ${DO_NOT_EXPORT+true}
then
  export DO_NOT_EXPORT=
  eval "$(pyenv init --path)"
  eval "$(pyenv virtualenv-init -)"
  source "$HOME/.poetry/env"
fi

source "$HOME/.cargo/env"

# Remove group write and other read/write permissions.
umask 026

export EDITOR=vim

# Don't put duplicate lines or lines starting with space in the history.
export HISTCONTROL='ignoreboth'
export HISTSIZE='50000000'
export HISTFILESIZE='50000000'
export HISTIGNORE="&:[bf]g:exit:pwd:l"
export HISTFILE="$HOME/.bash_history"
# Append to the history file instead of overwriting it.
shopt -s histappend

# Print notification only for interactive shells.
if [ -n "$(echo $- | grep i)" ]; then
  echo "sourced $HOME/.profile" >&2
fi
