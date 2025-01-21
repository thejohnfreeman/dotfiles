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

# https://unix.stackexchange.com/a/217223/42063
# Use the GNOME Keyring SSH Agent.

set -o vi

# Print notification only for interactive shells.
if [ -n "$(echo $- | grep i)" ]; then
  echo "sourced $HOME/.bashrc" >&2
fi

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
