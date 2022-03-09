#env vars
export ZDOTDIR="$HOME/.config/zsh"

export PATH=$HOME/.cargo/bin:$PATH:~/.local/bin:~/.scripts:/usr/local/go/bin:$HOME/go/bin
export EDITOR=nvim
export BROWSER=brave
export TERMINAL=kitty
export IMAGE_VIEWER=sxiv
export LC_TIME=en_US.utf8
export WALLPAPER_DIR="/mnt/Anime/Lucy/wallpapers"

export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
source "$HOME/.cargo/env" >/dev/null 2>&1
source $HOME/.nix-profile/etc/profile.d/nix.sh >/dev/null 2>&1

#vulkan SDK stuff
source "$HOME/programs/vulkan-sdk/1.2.170.0/setup-env.sh" >/dev/null 2>&1
. "$HOME/.cargo/env"
