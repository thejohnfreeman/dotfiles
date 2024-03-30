## Installation

- Add [u2f rules](https://docs.01.org/clearlinux/latest/tutorials/yubikey-u2f.html):

```
sudo apt install curl git
curl -O https://raw.githubusercontent.com/Yubico/libu2f-host/master/70-u2f.rules
sudo mv 70-u2f.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger
```

- Install the [Bitwarden addon for Firefox](https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/) and log in.

- Create an SSH key for this machine. Never copy the private half anywhere.

```
ssh-keygen -t rsa -b 4096 -C "$(whoami)@$(hostname)"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
```

- Log in to GitHub and [add your SSH key](https://github.com/settings/keys):

```
xclip -i -sel clip < ~/.ssh/id_rsa.pub
```

- Check out your dotfiles.

```
export GIT_DIR=$HOME/.files
git init --bare
git config --local status.showUntrackedFiles no
git remote add origin git@github.com:thejohnfreeman/dotfiles.git
git fetch
git --work-tree=$HOME checkout --force ubuntu
```

- Log out to update your PATH.

- Script the rest.

```
./README.sh
```

- [Create a GPG key for this machine.](https://superuser.com/questions/466396/how-to-manage-gpg-keys-across-multiple-systems)

## Acknowledgments

- [The best way to store your dotfiles: A bare Git repository](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)
- [How to git clone into an existing, non-empty directory](https://stackoverflow.com/a/33695754)
