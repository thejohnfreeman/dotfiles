## Installation

```
git clone --separate-git-dir=$HOME/.files git@github.com:thejohnfreeman/dotfiles.git $HOME
```

- [Base16 iTerm2](https://github.com/martinlindhe/base16-iterm2)

    ```
    git clone https://github.com/martinlindhe/base16-iterm2.git ~/code/base16-iterm2
    ```

    iTerm2
    -> Preferences
    -> Profiles
    -> Colors
    -> Color Presets
    -> Import
    -> `base16-tomorrow-night-256.itermcolors`

## Acknowledgments

[The best way to store your dotfiles: A bare Git repository](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)

```
git init --bare $HOME/.files
alias config='git --git-dir=$HOME/.files --work-tree=$HOME'
config config --local status.showUntrackedFiles no
```
