#!/bin/zsh
### Load OS specific integrations
if [[ $OSTYPE == darwin* ]]; then
	# load iterm2 shell integrations if they have been installed
	if [ -e $HOME/.iterm2_shell_integrations.zsh ]; then
		source $HOME/.iterm2_shell_integrations.zsh
	fi
	
	# load tldr completions if they exist
	if [ -e /opt/local/share/tldr-cpp-client/autocomplete/complete.zsh ]; then
		source /opt/local/share/tldr-cpp-client/autocomplete/complete.zsh
	fi
fi

# load fzf bindings if they are present
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

### Environment variables

# Set the editor to be 'bbedit' and make sure it opens a new instance
export EDITOR="vim"

# Add NVM and related completions
export NVM_DIR="$HOME/.nvm"


### Update $PATH with custom locations

# for JDK8 support
export JAVA_HOME=~/Library/Java/JavaVirtualMachines/adopt-openjdk-1.8.0_292/Contents/Home

# for GO
export GOPATH=$HOME/Development
export PATH=$PATH:$GOPATH/bin

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
