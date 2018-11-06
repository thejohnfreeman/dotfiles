https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/

```
git init --bare $HOME/.files
alias config='git --git-dir=$HOME/.files --work-tree=$HOME'
config config --local status.showUntrackedFiles no
```

```
git clone --separate-git-dir=$HOME/.files https://github.com/thejohnfreeman/dotfiles $HOME
```
