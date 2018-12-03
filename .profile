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

if test ${DO_NOT_EXPORT+true}
then
  export DO_NOT_EXPORT=
fi

set -o vi
export EDITOR=vim

export HISTCONTROL='ignoredups'
export HISTSIZE='50000000'
export HISTFILESIZE='50000000'
export HISTIGNORE=" *:&:[bf]g:exit:pwd:l"
export HISTFILE="$HOME/.bash_history"
shopt -s histappend

# Print notification only for interactive shells.
if [ -n "$(echo $- | grep i)" ]; then
  echo "sourced $HOME/.profile" >&2
fi

source ~/.bashrc
source ~/.bash_prompt
