## Installation

```
git clone --separate-git-dir=$HOME/.files https://github.com/thejohnfreeman/dotfiles $HOME
```

- [Base16 Shell](https://github.com/chriskempson/base16-shell)

    ```
    git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
    ```

- [Base16 iTerm2](https://github.com/martinlindhe/base16-iterm2)

## Acknowledgments

[The best way to store your dotfiles: A bare Git repository](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)

```
git init --bare $HOME/.files
alias config='git --git-dir=$HOME/.files --work-tree=$HOME'
config config --local status.showUntrackedFiles no
```
