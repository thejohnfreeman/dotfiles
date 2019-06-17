# In Terminal and iTerm2, `.bashrc` is never executed when opening a new
# window or tab.

# In tmux, `.bashrc` is executed for each new window or pane, and those shells
# inherit the exports from the environment in which tmux was started.

# Bash executes `.bashrc`. for interactive subshells. We don't want `.bashrc`
# to export any environment variables because they will be inherited. At best,
# it re-exports the same value, which is effectively a no-op. At worst, it
# pads the same prefix onto the `$PATH` which grows out-of-control.

source ~/.bash_aliases
source ~/.bash_prompt

set -o vi

# fzf will flip if this line is not in `.bashrc`, so leave it here. I've
# checked that it plays nicely with environment variables.
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Print notification only for interactive shells.
if [ -n "$(echo $- | grep i)" ]; then
  echo "sourced $HOME/.bashrc" >&2
fi
