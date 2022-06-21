#!/bin/zsh

### Load OS specific integrations
if [[ $OSTYPE == darwin* ]]; then
	# load iterm2 shell integrations if they have been installed
	if [ -e $HOME/.iterm2_shell_integrations.zsh ]; then
        export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES
		source $HOME/.iterm2_shell_integrations.zsh
	fi
	
	# load tldr completions if they exist
	if [ -e /opt/local/share/tldr-cpp-client/autocomplete/complete.zsh ]; then
		source /opt/local/share/tldr-cpp-client/autocomplete/complete.zsh
	fi
fi

# load fzf bindings if they are present
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if [ -f /opt/local/share/fzf/shell/key-bindings.zsh ]; then
    source /opt/local/share/fzf/shell/key-bindings.zsh
fi

# Effectively set the history size to unlimited
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000

# Don't write duplicate commands to the history file
setopt HIST_IGNORE_ALL_DUPS
# Share zsh history across all terminal windows
setopt share_history

export HISTTIMEFORMAT="[%F %T] "
setopt EXTENDED_HISTORY

# Set the editor
export EDITOR="vim"

# When setting the EDITOR to 'vim' ZSH will adopt vim bindings on the cmdline
# this forces it to 'emacs' mode makes the commandline behave "like normal"
setopt emacs

# Share history between shell instances
setopt share_history

# Make JAVA_HOME point to the default JDK
export JAVA_HOME="$(/usr/libexec/java_home)" 

# for GO
export GOPATH=$HOME/Developer/go
export PATH=$PATH:$GOPATH/bin

# Add nvm completions to the path
export NVM_DIR="$HOME/.nvm"

export TIMEFMT="
________________________________________________________
  %J
    Executed in %*Es (%mE)
    User in (ms):	%mU
    System in (ms):	%mS
"

#     Socket Messages Sent: %s
#     Socket Messages Recv: %r

# Fish Output
#________________________________________________________
#Executed in  120.11 millis    fish           external
#   usr time    5.69 millis  101.00 micros    5.59 millis
#   sys time   11.41 millis  424.00 micros   10.98 millis

export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
