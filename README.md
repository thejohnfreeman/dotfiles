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
git checkout --force yadm
# Install YADM.
git submodule update --init --recursive
alias yadm="${HOME}/.yadm.git/yadm"
```

[YADM]: https://yadm.io

- Bootstrap.

```
yadm alt
yadm bootstrap
```

- Log out to update your PATH.

- Install the [Bitwarden addon for Firefox](https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/) and log in.

- Log in to GitHub and [add your SSH key](https://github.com/settings/keys):

```
xclip -i -sel clip < ~/.ssh/id_ed25519.pub
```

- Copy PGP keys.

```
# On your primary key machine:
fingerprint() { awk -F\: '/^fpr/ { print $10 }'; }
export GNUPGHOME=~/gnupg
primary=$(gpg --list-keys --with-colons | head -3 | fingerprint)
# You need your passphrase for this step.
gpg --quick-add-key ${primary} ed25519 sign 2y
subkey=$(gpg --list-keys --with-colons | tail -3 | fingerprint)
# Need passphrase.
gpg --armor --export-secret-subkeys ${subkey}! >subkey.asc
gpg --armor --export >>subkey.asc
scp subkey.asc $(whoami)@${remote}:/home/$(whoami)/
```

```
# On your new machine:
# Need passphrase.
gpg --import subkey.asc
gpg --batch --command-fd 0 --edit-key jfreeman08@gmail.com <<EOF
trust
5
y
save
EOF
```

When it comes time to update expiration:

```
# On your primary key machine:
gpg --quick-set-expire ${primary} 2y '*'
# Repeat the export and import steps above.
```


## Acknowledgments

- [The best way to store your dotfiles: A bare Git repository](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)
- [How to git clone into an existing, non-empty directory](https://stackoverflow.com/a/33695754)
