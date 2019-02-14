## Installation

```
export GIT_DIR=$HOME/.files
git init --bare
git remote add origin git@github.com:thejohnfreeman/dotfiles.git
git fetch
git --work-tree=$HOME checkout --force ubuntu
```

- [Base16 Gnome Terminal](https://github.com/aaron-williamson/base16-gnome-terminal)

  ```
  git clone https://github.com/aaron-williamson/base16-gnome-terminal.git ~/.config/base16-gnome-terminal
  ~/.config/base16-gnome-terminal/color-scripts/base16-tomorrow-night-256.sh
  ```

  Then select new profile in preferences and restart terminal.

## Acknowledgments

- [The best way to store your dotfiles: A bare Git repository](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)

  ```
  git init --bare $HOME/.files
  alias config='git --git-dir=$HOME/.files --work-tree=$HOME'
  config config --local status.showUntrackedFiles no
  ```

- [How to git clone into an existing, non-empty directory](https://stackoverflow.com/a/33695754)
