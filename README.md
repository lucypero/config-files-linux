# Lucy's Linux configuration files

This was done following the instructions for how to version configuration files [from this article](https://www.atlassian.com/git/tutorials/dotfiles).

# Installation

- Run this on zsh:

  (**WARNING**: This will override all the files already in the system that have the same name as the ones on this repository.)

```bash
cd ~
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
git clone --bare https://github.com/lucypero/config-files-linux.git $HOME/.cfg
config checkout --force
config config --local status.showUntrackedFiles no
```
- Reload the shell.
