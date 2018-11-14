## Installation

```
git clone --separate-git-dir=$HOME/.files git@github.com:thejohnfreeman/dotfiles.git $HOME
```

- [Base16 Shell](https://github.com/chriskempson/base16-shell)

    ```
    git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
    ```

- [Base16 Gnome Terminal](https://github.com/aaron-williamson/base16-gnome-terminal)

    ```
    git clone https://github.com/aaron-williamson/base16-gnome-terminal.git ~/.config/base16-gnome-terminal
    ~/.config/base16-gnome-terminal/color-scripts/base16-tomorrow-night-256.sh
    ```

## Acknowledgments

[The best way to store your dotfiles: A bare Git repository](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)

```
git init --bare $HOME/.files
alias config='git --git-dir=$HOME/.files --work-tree=$HOME'
config config --local status.showUntrackedFiles no
```
