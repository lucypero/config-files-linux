#!/bin/sh
export ANTIGEN_AUTO_CONFIG=false

source ~/.config/zsh/antigen.zsh
antigen use oh-my-zsh
antigen bundle Aloxaf/fzf-tab
antigen bundle last-working-dir
antigen apply

# WSL stuff
IS_WSL=false
if [ $(uname -r | sed -n 's/.*\( *Microsoft *\).*/\1/ip') ];
then
  IS_WSL=true
fi

export COLORTERM=truecolor

#golang stuff
export GO111MODULE=on

autoload -Uz promptinit
autoload -U colors && colors

promptinit

# Do not require a leading '.' in a filename to be matched explicitly
setopt globdots

# Default prompt
prompt fade magenta

#History in cache directory:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.cache/zsh/history
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed
# Do not enter command lines into the history list if they are duplicates of the
# previous event.
setopt histignorealldups
# Remove superfluous blanks from each command line being added to the history
# list
setopt histreduceblanks

# Command completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
setopt COMPLETE_ALIASES
compinit
_comp_options+=(globdots) #include hidden files


# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Truncates path for the prompt
pwd_t() {
  V=$(pwd)
  max_len=35

  if [ ${#V} -ge $max_len ]
  then
    echo "(...)${V: -$max_len}"
  else
    echo ${V}
  fi
}

PROMPT='%B%F{219}[%f%b%B%F{219}%n%f%b %B$(pwd_t)%B%F{219}]%(!.#.$)%f%b '

### aliases
alias e='$EDITOR'
if [ $IS_WSL = true ]; then
  alias c='clip.exe'
  alias cpwd='wslpath -w "$(pwd)" | clip.exe'
else
  alias c='xclip -selection clipboard'
fi
alias ls='exa --color=never --icons -a'
alias lua='lua5.3'
alias xr='xrdb ~/.config/.Xresources'
alias makeexec='chmod +x'
alias wom='man' # :^)
# 'go to' shortcuts
alias gos='cd ~/.scripts' # to
alias god='cd ~/dev'
alias gon='cd ~/docs'
alias goc='cd ~/dev/chess'
alias b='cd ../'
# activate python venv
alias avenv='source .venv/bin/activate'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias lconfig='lazygit --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias lg='lazygit'
alias mg='menu-game'
alias ex='explorer.exe .'

# aliases for building godot
alias gb='python3.exe build_godot.py'
# build debug target
alias gbd='python3.exe build_godot.py -t debug -o'
# build release target
alias gbr='python3.exe build_godot.py -t release'
# just run the game on the switch
alias gbg='python3.exe build_godot.py -t debug -f'
# build debug target and run the game on the switch
alias gbdr='python3.exe build_godot.py -t debug -r'

alias un='sudo $HOME/.scripts/update-nvim'

## font preview aliases using fontpreview-ueberzug

#running it straight from git repo to test the new feature i requested
fp='/home/lucy/programs/fontpreview-ueberzug/fontpreview-ueberzug'

alias fp="$fp"
# to preview code text
alias fpc='$fp -s 16 -a left -t "
fn main() {
    let original_price = 51;
    println!(\"Your sale price is {}\", sale_price(original_price));
}

fn sale_price(price: i32) -> i32{
    if is_even(price) {
        return price - 10
    } else {
        return price - 3
    }
}

fn is_even(num: i32) -> bool {
    num % 2 == 0
}
"'

#clean cpp project (delete obj files.)
alias clean-project="find . -type f -name '*.obj' -exec rm {} +;find . -type f -name '*.o' -exec rm {} +"

#close discord)
alias dc="taskkill.exe /f /im discord.exe"

#fzf config
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="rg --files --hidden -g'!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# fzf colors
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=hl:#ffb8f6,fg+:-1,hl+:#ffb8f6,info:#ffb8f6,prompt:#ffb8f6,pointer:#ff91f0,marker:-1,spinner:#ffb8f6,header:#ffb8f6,bg:-1,bg+:-1'

#functions for convenience

#edit config files in ~/.config or ~/.scripts using zfz
ec() { rg --hidden --files ~/.scripts ~/.config | fzf | xargs -r $EDITOR ;}
#edit zshrc
ecz() { $EDITOR ~/.config/zsh/.zshrc }
#edit wezterm
ecw() { $EDITOR /mnt/c/Users/Lucy/.config/wezterm/wezterm.lua }
#edit bookmarks
ecb() { $EDITOR ~/docs/bookmarks }
#edit vim config
ecv() { $EDITOR ~/.config/nvim/init.vim }
#edit awesome config
eca() { $EDITOR ~/.config/awesome/rc.lua }
#edit polybar
ecp() { $EDITOR ~/.config/polybar/config.ini }
#edit notes
en() { rg --hidden --files ~/docs ~/Anime/Lucy/therapy | fzf | xargs -r $EDITOR ;}
#turn on/off internet (args are up/down)
internet() {sudo ip link set enp6s0 $1}
#Change Directory (Interactive) using fzf
cdi() { cd $(find . -type d | fzf);zle reset-prompt }
zle -N change-dir-fzf cdi
bindkey '^p' change-dir-fzf

#search files
rgf() { rg --hidden --files | rg $1 }

#add PWD to bookmarks
ba() { echo $PWD >> ~/docs/bookmarks }
#go to favorite directory using fzf
f() {
  cd "$(cat ~/docs/bookmarks | fzf)"
  zle reset-prompt
}
zle -N fav-dir f
bindkey '^f' fav-dir
#run favorite executable using fzf
run() {
  executable="$(cat ~/docs/exe-bookmarks | fzf)"
  $executable
}
zle -N fav-exe run
bindkey '^r' fav-exe


# lf colors
export LF_COLORS="\
ln=00:\
di=00:\
ex=00:\
or=00:\
tw=00:\
ow=00:\
st=00:\
pi=00:\
so=00:\
bd=00:\
cd=00:\
su=00:\
sg=00:\
ex=00:\
fi=00:\
"

#black font for fzf-tab (for light theme)
enable-fzf-tab

# mouse sens
#chsens 0.6

# open vim in bookmark folder
ef() { 
  cd "$(cat ~/docs/bookmarks | fzf)"
  $EDITOR
}
