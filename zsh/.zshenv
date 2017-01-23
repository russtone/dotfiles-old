#	XDG {{{ #

# XDG dirs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Environment-variable respecting programs
export ADB_VENDOR_KEYS="$XDG_DATA_HOME/android/.android"
export ANDROID_SDK_HOME="$XDG_DATA_HOME/android"
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/config"
export BABEL_DISABLE_CACHE=1
export BOOKMARKS_FILE="$XDG_DATA_HOME/zsh/bookmarks"
export CP_HOME_DIR="$XDG_DATA_HOME/cocoapods"
export CP_REPOS_DIR="$XDG_DATA_HOME/cocoapods/repos"
export DOT_SAGE="$XDG_DATA_HOME/sage"
export GEM_HOME="$XDG_DATA_HOME/ruby/gem"
export GEM_PATH="$XDG_DATA_HOME/ruby/gem"
export GEM_SPEC_CACHE="$GEM_HOME/specs"
export GIT_SSH_COMMAND="ssh -F $XDG_CONFIG_HOME/ssh/config "$@" 2>/dev/null"
export GLIDE_HOME="$XDG_CACHE_HOME/glide"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GOPATH="$XDG_DATA_HOME/golang"
export GRADLE_USER_HOME="$XDG_CACHE_HOME/gradle"
export HISTFILE="$XDG_DATA_HOME/zsh/history"
export LESSHISTFILE="$XDG_DATA_HOME/less/history"
export MSF_CFGROOT_CONFIG="$XDG_DATA_HOME/metasploit"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/config"
export TASKDATA="$XDG_DATA_HOME/task"
export TASKRC="$XDG_CONFIG_HOME/task/config"
export TMUX_PLUGIN_MANAGER_PATH="$XDG_DATA_HOME/tmux/plugins"
export VAGRANT_HOME="$XDG_DATA_HOME/vagrant"
export ZPLUG_HOME="$XDG_DATA_HOME/zsh/zplug"


# Alias respecting programs
alias ag="ag -p $XDG_CONFIG_HOME/ag/agignore"
alias ctags="ctags --config-filename=config/ctags/ctags.conf" # Hack
alias rsyncs="rsync -e \"ssh -F $XDG_CONFIG_HOME/ssh/config\""
alias scp="scp -F $XDG_CONFIG_HOME/ssh/config"
alias ssh="ssh -F $XDG_CONFIG_HOME/ssh/config"
alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
alias ptpython="ptpython --config-dir $XDG_CONFIG_HOME/ptpython"

#	}}} XDG #

#	Environment {{{ #

export LANG='en_US.UTF-8'
export PAGER='less'

if (( $+commands[nvim] )); then
	export EDITOR='nvim'
	export VISUAL='nvim'
else
	export EDITOR='vim'
	export VISUAL='vim'
fi

# Private
source $ZDOTDIR/private.zsh

# Path
typeset -U path
path=(
	$HOME/.local/bin
	/usr/local/{bin,sbin}
	$GOPATH/bin
	$GEM_HOME/bin
	$HOME/Library/Android/sdk/platform-tools
	$HOME/Library/Android/sdk/tools
	/opt/SageMath
	$path
)

# Manpath
typeset -U manpath
manpath=(
	$ZPLUG_HOME/doc/man
	/usr/local/share/man
	/usr/share/man
)

#	}}} Environment #
