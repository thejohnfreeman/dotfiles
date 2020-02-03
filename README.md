## Installation

- Add [u2f rules](https://docs.01.org/clearlinux/latest/tutorials/yubikey-u2f.html):

```
sudo apt install curl git
curl -O https://raw.githubusercontent.com/Yubico/libu2f-host/master/70-u2f.rules
sudo mv 70-u2f.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger
```

- Install the [LastPass addon for Firefox](https://addons.mozilla.org/en-US/firefox/addon/lastpass-password-manager/) and log in.

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

- Settle in and script the rest.

```
source .bash_aliases
./README.sh
```

- [Base16 Gnome Terminal](https://github.com/aaron-williamson/base16-gnome-terminal)

  ```
  git clone https://github.com/aaron-williamson/base16-gnome-terminal.git ~/.config/base16-gnome-terminal
  ~/.config/base16-gnome-terminal/color-scripts/base16-tomorrow-night-256.sh
  ```

  Then select new profile in preferences and restart terminal.

## Acknowledgments

- [The best way to store your dotfiles: A bare Git repository](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)
- [How to git clone into an existing, non-empty directory](https://stackoverflow.com/a/33695754)
