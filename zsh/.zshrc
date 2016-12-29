# Plugins {{{ #

# Auto install zplug
if [[ ! -d $ZPLUG_HOME ]]; then
	git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "urbainvaes/fzf-marks"
zplug "zsh-users/zsh-autosuggestions"
zplug "morhetz/gruvbox", use:"gruvbox_256palette.sh"

zplug "$ZDOTDIR", use:clipboard.zsh, from:local
zplug "$ZDOTDIR", use:prompt.zsh, from:local

zplug load

# }}} Plugins #

# Key bindings {{{ #

bindkey -e
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# }}} Key bindings #

# Dircolors {{{ #

if (( $+commands[gdircolors] )); then
	dircolors_cmd='gdircolors'
elif (( $+commands[dircolors] )); then
	dircolors_cmd='dircolors'
fi

if [[ ! -z $dircolors_cmd ]]; then
	eval "$($dircolors_cmd --sh "$XDG_CONFIG_HOME/dircolors/dircolors")"
fi

# }}} Dircolors #

# Aliases {{{ #

alias ll='ls -lh' # Lists human readable sizes
alias lr='ll -R'  # Lists human readable sizes, recursively
alias la='ll -A'  # Lists human readable sizes, hidden files
alias cd='cd -P'  # Change $PWD when cd to symlink
alias p='python'
alias p3='python3'
alias pp='ptpython'
alias v='nvim'
alias r='ranger'
alias mux='tmuxinator'
alias msf='/opt/metasploit-framework/bin/msfconsole'
alias msfv='/opt/metasploit-framework/bin/msfvenom'

# ls
if (( $+commands[gls] )); then
	ls_cmd='gls'
else
	ls_cmd='ls'
fi
alias ls="$ls_cmd --color=auto --group-directories-first"

# open
if (( $+commands[xdg-open] )); then
	alias open='xdg-open'
fi

# }}} Aliases #

# Completions {{{ #

# Case insensetive completion
zstyle ':completion:*' matcher-list \
	'm:{[:lower:]}={[:upper:]}'\
	'm:{[:upper:]}={[:lower:]}'

# Use cache
zstyle ':completion::complete:*' use-cache on

# Cache file path
zstyle ':completion::complete:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

# Use menu if more than one result
zstyle ':completion:*:*:*:*:*' menu select

# Format of group name
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'

# Colors in completion menu
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# }}} Completions #

# History {{{ #

# Variables
HISTSIZE=100000
SAVEHIST=100000

# Options
setopt SHARE_HISTORY        # Share history between all sessions
setopt HIST_IGNORE_DUPS     # Do not record an event that was just recorded again
setopt HIST_IGNORE_ALL_DUPS # Delete an old recorded event if a new event is a duplicate
setopt HIST_FIND_NO_DUPS    # Do not display a previously found event
setopt HIST_IGNORE_SPACE    # Do not record an event starting with a space
setopt HIST_SAVE_NO_DUPS    # Do not write a duplicate event to the history file
setopt HIST_VERIFY          # Do not execute immediately upon history expansion

# }}} History #

# Expand .. {{{ #

# Expands .... to ../..
function expand-dot-to-parent-directory-path() {
	if [[ $LBUFFER = *.. ]]; then
		LBUFFER+='/..'
	else
		LBUFFER+='.'
	fi
}
zle -N expand-dot-to-parent-directory-path
bindkey '.' expand-dot-to-parent-directory-path

# }}} Expand .. #

#	Copy & paste {{{ #

if (( $+functions[clipcopy] )); then
	function clip-copy-region-as-kill() {
		zle copy-region-as-kill
		print -rn $CUTBUFFER | clipcopy
	}
	zle -N clip-copy-region-as-kill
	bindkey '^W' clip-copy-region-as-kill
fi

if (( $+functions[clippaste] )); then
	function clip-yank() {
		CUTBUFFER=$(clippaste)
		zle yank
	}
	zle -N clip-yank
	bindkey '^Y' clip-yank
fi

#	}}} Copy & paste #

#	FZF {{{ #

if (( $+commands[fzf] )); then

	# Color scheme
	export FZF_DEFAULT_OPTS='
	 --color fg:15,bg:0,hl:3,fg+:3,bg+:0,hl+:3
	 --color info:7,prompt:2,spinner:3,pointer:4,marker:3
	'

	# Use ag if possible
	if (( $+commands[ag] )); then
		export FZF_DEFAULT_COMMAND='ag -g ""'
	fi

	# fzf-marks
	alias j='jump'
	alias m='mark'

fi

#	}}} FZF #

# vim: fdm=marker
