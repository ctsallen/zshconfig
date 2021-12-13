#!/bin/zsh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# add the custom functions and completions paths to the fpath variable 
fpath=(
    $HOME/.zsh/functions
    $HOME/.zsh/completions
    $HOME/.zsh/plugins/zsh-completions/src
    /opt/local/share/zsh/site-functions
    $fpath
)

# flag all functions for autoloading so that they get loaded as needed
autoload -Uz ~/.zsh/functions/**/*

# autoload compinit for completions and only reload the cache once a day 
autoload -Uz compinit
if [ -f ${ZDOTDIR:-$HOME}/.zcompdump ]; then
    if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' ${ZDOTDIR:-$HOME}/.zcompdump) ]; then
        compinit
    else
        compinit -C
    fi
else
    compinit -C
fi

# source aliases that I use reguarly 
source ~/.zsh/aliases

# zstyle updates

# enable "smart" case matching when auto-completing. 
# e.g. Case-Sensitive when starting with a capital letter, case-insensitive when starting with a lower case one
#zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# Completion caching
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path .zcache
zstyle ':completion:*:cd:*' ignore-parents parent pwd

#Completion Options
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate
zstyle ':completion:*:*:*:default' menu yes select
#zstyle ':completion:*:*:default' force-list always

# Path Expansion
# zstyle ':completion:*' expand 'yes'
# zstyle ':completion:*' squeeze-shlashes 'yes'
# zstyle ':completion::complete:*' '\\'

# Group matches and Describe
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
#zstyle ':completion:*:options' auto-description '%d'
#zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
#zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'

# plugins
source ~/.zsh/plugins/enhancd/init.sh
source ~/.zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Fix Alt+Backspace to stop on non-word characters
# (see: https://unix.stackexchange.com/questions/313806/zsh-make-altbackspace-stop-at-non-alphanumeric-characters)
backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
    zle -f kill
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir

# Allow shift+tab to reverse menu search
bindkey '^[[Z' reverse-menu-complete

# Allow fzf-cd-widget to behave correctly with ALT-C
bindkey "ç" fzf-cd-widget
