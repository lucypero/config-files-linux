#!/bin/sh

# (I didn't test this yet)
# I followed this tutorial for storing my config files.
#    https://www.atlassian.com/git/tutorials/dotfiles

# U need git and yay installed before this
# Run this script on $HOME

git clone --bare https://github.com/lucypero/config-files.git $HOME/.cfg
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout
echo "config is checked out."
echo "Installing all packages in pkglist.txt..."
yay -S - < pkglist.txt
echo "everything checked out. Run zsh again now."
