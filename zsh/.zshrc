# Plugins {{{ #

# Auto install zplug
if [[ ! -s $ZPLUG_HOME/zplug ]]; then
  curl -fLo $ZPLUG_HOME/zplug \
    --create-dirs https://raw.githubusercontent.com/b4b4r07/zplug/master/zplug
fi

source $ZPLUG_HOME/zplug

zplug "russtone/prompt-russtone", of:"theme.zsh"
zplug "russtone/zsh-clipboard"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", nice:10

zplug load

# }}} Plugins #

# Key bindings {{{ #

bindkey -e
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# }}} Key bindings #

# dircolors {{{ #

# Set dircolors
if (( ! $+commands[gdircolors] )); then
  echo "Warning: 'gdircolors' command not found!"
  return 1
fi

if [[ -s "$XDG_CONFIG_HOME/dircolors" ]]; then
  eval "$(gdircolors --sh "$XDG_CONFIG_HOME/dircolors")"
fi

# ls alias
if (( ! $+commands[gls] )); then
  echo "Warning: 'gls' command not found!"
  return 1
fi

alias ls='gls --color=auto --group-directories-first'


# }}} dircolors #

# Aliases {{{ #

# ls aliases
alias l='ls -1A'         # Lists in one column, hidden files
alias ll='ls -lh'        # Lists human readable sizes
alias lr='ll -R'         # Lists human readable sizes, recursively
alias la='ll -A'         # Lists human readable sizes, hidden files
alias lk='ll -Sr'        # Lists sorted by size, largest last
alias lt='ll -tr'        # Lists sorted by date, most recent last

# cd follow symlink
alias cd='cd -P'

# Python
alias p='python'
alias pp='ptpython'

# Vim
alias v='nvim'

# Tmux
alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"

# }}} Aliases #

# Completions {{{ #

# Case insensetive completion
zstyle ':completion:*' matcher-list \
  'm:{[:lower:]}={[:upper:]}'\
  'm:{[:upper:]}={[:lower:]}'

# Use cache
zstyle ':completion::complete:*' use-cache on

# Cache file path
zstyle ':completion::complete:*' cache-path "$XDG_CACHE_HOME/zsh/compcache"

# Use menu if more than one result
zstyle ':completion:*:*:*:*:*' menu select

# Format of group name
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'

# Colors in completion menu
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
# zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
# zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
# zstyle ':completion:*' squeeze-slashes true

# Fuzzy match mistyped completions
# zstyle ':completion:*' completer _complete _match _approximate
# zstyle ':completion:*:match:*' original only
# zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Ignore
# zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

# History
# zstyle ':completion:*:history-words' stop yes
# zstyle ':completion:*:history-words' remove-all-dups yes
# zstyle ':completion:*:history-words' list false
# zstyle ':completion:*:history-words' menu yes

# Populate hostname completion.
# zstyle -e ':completion:*:hosts' hosts 'reply=(
#   ${=${=${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) 2>/dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
#   ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2>/dev/null))"}%%\#*}
#   ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2>/dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
# )'

# Don't complete uninteresting users...
# zstyle ':completion:*:*:*:users' ignored-patterns \
#   adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
#   dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
#   hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
#   mailman mailnull mldonkey mysql nagios \
#   named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
#   operator pcap postfix postgres privoxy pulse pvm quagga radvd \
#   rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'

# ... unless we really want to
# zstyle '*' single-ignored show

# Ignore multiple entries
# zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
# zstyle ':completion:*:rm:*' file-patterns '*:all-files'

# Kill
# zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
# zstyle ':completion:*:*:kill:*' menu yes select
# zstyle ':completion:*:*:kill:*' force-list always
# zstyle ':completion:*:*:kill:*' insert-ids single

# Man
# zstyle ':completion:*:manuals' separate-sections true
# zstyle ':completion:*:manuals.(^1*)' insert-sections true

# SSH/SCP/RSYNC
# zstyle ':completion:*:(scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
# zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
# zstyle ':completion:*:ssh:*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
# zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
# zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
# zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
# zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

# }}} Completions #

# History {{{ #

# Variables
HISTFILE="$XDG_DATA_HOME/zsh/history"  # The path to the hstory file
HISTSIZE=10000                          # The maximum number of events to save in the internal history
SAVEHIST=10000                          # The maximum number of events to save in the history file

# Options
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits
setopt SHARE_HISTORY             # Share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file
setopt HIST_VERIFY               # Do not execute immediately upon history expansion

# }}} History #

# Tmux {{{ #

# Return if requirements are not found
if (( ! $+commands[tmux] )); then
  echo "Warning: 'tmux' command not found!"
  return 1
fi

if [[ -z "$TMUX" && -z "$SSH_TTY" ]];  then

  # Check session exist
  if ! tmux has-session 2> /dev/null; then
    tmux new-session -d -s 'global'
  fi

  exec tmux new-session -d -t 'global' -s 'russtone' \; set-option destroy-unattached \; attach-session -t 'russtone'
fi

# }}} Tmux #

# Expand .. {{{ #

# Expands .... to ../..
function expand-dot-to-parent-directory-path {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+='/..'
  else
    LBUFFER+='.'
  fi
}
zle -N expand-dot-to-parent-directory-path
bindkey -M viins '.' expand-dot-to-parent-directory-path

# }}} Expand .. #

#  Copy & paste {{{ #

function clip-copy-region-as-kill() {
  zle copy-region-as-kill
  print -rn $CUTBUFFER | clipcopy
}
zle -N clip-copy-region-as-kill

function clip-yank() {
  CUTBUFFER=$(clippaste)
  zle yank
}
zle -N clip-yank

bindkey '^W' clip-copy-region-as-kill
bindkey '^Y' clip-yank

#  }}} Copy & paste #

# vim: fdm=marker