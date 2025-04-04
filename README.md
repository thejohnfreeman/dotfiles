## Installation

- Install Git.

```
sudo apt install git
sudo pamac install git
```

- Check out your dotfiles.

```
export GIT_DIR=$HOME/.local/share/yadm/repo.git
mkdir -p "$(dirname "${GIT_DIR}")"
git init --bare --initial-branch master
git config --local status.showUntrackedFiles no
git config --local core.bare false
git config --local core.worktree "${HOME}"
git remote add origin https://github.com/thejohnfreeman/dotfiles.git
git fetch origin yadm
git checkout --force yadm --recurse-submodules
# Install YADM.
alias yadm="${HOME}/.yadm.git/yadm"
```

[YADM]: https://yadm.io

- Bootstrap.

```
yadm alt
```

- Install the [Bitwarden addon for Firefox](https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/) and log in.

- Log in to GitHub and [add your SSH key](https://github.com/settings/keys):

```
xclip -i -sel clip < ~/.ssh/id_ed25519.pub
```

- Log out to update your PATH.

- Copy GPG keys.

```
# sudo systemctl start ssh
ssh-copy-id jfreeman@franklin
scp -r jfreeman@franklin:~/gnupg .
# sudo systemctl stop ssh
rm -rf .gnupg
mv gnupg .gnupg
export GPG_TTY=$(tty)
gpg -o- --clearsign /dev/null
```


## Acknowledgments

- [The best way to store your dotfiles: A bare Git repository](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)
- [How to git clone into an existing, non-empty directory](https://stackoverflow.com/a/33695754)
