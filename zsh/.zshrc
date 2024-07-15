# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# history settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

PATH="$PATH:$HOME/.local/bin:/usr/local/go/bin:$HOME/.platformio/penv/bin:$HOME/.cargo/bin"

XDG_CURRENT_DESKTOP=sway

# nvim
alias vim="nvim"

# pip
alias pip3="/usr/bin/python3 -m pip"

# docker
alias prune="yes | docker container prune && yes | docker image prune"
dlogs () {
    docker logs $1 2>&1 | grep $2
}

# go
GOPATH=~/projects/go

# network tools
alias get-public-ip="curl -w '\n' https://ipinfo.io/ip"

set-mac () {
    nmcli connection modify --temporary $1 802-11-wireless.cloned-mac-address $2
    nmcli connection up $1
}

# exa
alias ls="eza -a"

# rg
alias grep="rg"

# bat
alias cat="bat --paging=never --style=header"

# dd with sane defaults
ds () {
    sudo dd if=$1 of=$2 bs=4M && sync
}

# ssh tools
ssh-keyput () {
    ssh-copy-id -i ~/.ssh/id_ed25519.pub $USERNAME@$1
}

# display configuration
find_ext () {
    regex="LG\sElectronics\sLG\sULTRAGEAR\s\w+\s\((DP-[0-9]+)"
    w_out=$(wlr-randr)
    if [[ $w_out =~ $regex  ]]
    then
        echo $match
    else
        :
    fi
}

find_tablet () {
    regex="Cintiq\sPro\s\w+\s\w+\s\((DP-\w+)\)"
    w_out=$(wlr-randr)
    if [[ $w_out =~ $regex  ]]
    then
        echo $match
    else
        :
    fi
}

screen-ext-tablet () {
    wlr-randr --output eDP-1 --off
    wlr-randr --output $(find_ext) --on
    wlr-randr --output $(find_tablet) --on
    swaymsg input 1386:847:Wacom_Cintiq_Pro_13_Pen map_to_output $(find_tablet)
    screen-ext-reset
}

screen-tablet () {
    screen_tablet=$(find_tablet)
    screen_ext=$(find_ext)
    wlr-randr --output eDP-1 --off
    wlr-randr --output $screen_ext --off
    wlr-randr --output $screen_ext --on
    swaymsg input 1386:847:Wacom_Cintiq_Pro_13_Pen map_to_output $screen_tablet
}

screen-ext () {
    wlr-randr --output eDP-1 --off
    wlr-randr --output $(find_tablet) --off
    wlr-randr --output $(find_ext) --on
    screen-ext-reset
}

screen-ext-reset () {
    wlr-randr --output $(find_ext) --mode 2560x1440@119.998001Hz
}

screen-int () {
    wlr-randr --output $(find_ext) --off
    wlr-randr --output $(find_tablet) --off
    wlr-randr --output eDP-1 --on
}

screen-int-ext () {
    wlr-randr --output eDP-1 --on
    wlr-randr --output $(find_ext) --on
    screen-ext-reset
}

fix-keys() {
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/authorized_keys
}

# keybinds
bindkey "^[[3~" delete-char

# local, non-tracked files
[ -f ~/.env.local ] && source ~/.env.local
[ -f ~/.alias.local ] && source ~/.alias.local
[ -f ~/.functions.local ] && source ~/.functions.local

eval "$(atuin init zsh)"
