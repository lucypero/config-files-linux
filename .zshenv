. "$HOME/.cargo/env" >/dev/null 2>&1
ZDOTDIR="$HOME/.config/zsh"
. "$ZDOTDIR/.zshenv"

if [ -e /home/lucy/.nix-profile/etc/profile.d/nix.sh ]; then . /home/lucy/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
