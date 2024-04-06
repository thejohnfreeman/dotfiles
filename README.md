## Installation

- Check out your dotfiles.

```
export GIT_DIR=$HOME/.files
git init --bare
git config --local status.showUntrackedFiles no
git remote add origin https://github.com/thejohnfreeman/dotfiles.git
git fetch
git --work-tree=$HOME checkout --force manjaro
```

- Bootstrap.

```
source README.sh
```

- Install the [Bitwarden addon for Firefox](https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/) and log in.

- Log in to GitHub and [add your SSH key](https://github.com/settings/keys):

```
xclip -i -sel clip < ~/.ssh/id_ed25519.pub
```

- Log out to update your PATH.

- [Create a GPG key for this machine.](https://superuser.com/questions/466396/how-to-manage-gpg-keys-across-multiple-systems)


## Acknowledgments

- [The best way to store your dotfiles: A bare Git repository](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)
- [How to git clone into an existing, non-empty directory](https://stackoverflow.com/a/33695754)
