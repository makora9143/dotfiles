bindkey -e
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "^[[Z" reverse-menu-complete

autoload history-search-end
autoload -Uz compinit && compinit -u
autoload -Uz colors && colors
# zstyle ':completion:*' list-colors 'di=36' 'ln=35'
# zstyle ':completion:*:default' menu select=1
# export LS_COLORS='di=35:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# zstyle ':completion:*' list-colors 'di=35' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*' list-colors ${(s.;.)LS_COLORS}
# zstyle ':completion:*' list-colors 'di=35:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# [ -f ~/.zshrc.include ] && source ~/.zshrc.include
zstyle ':completion:*:default' menu select=2
##補完に関するオプション
setopt auto_param_slash      # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs             # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt list_types            # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
setopt auto_menu             # 補完キー連打で順に補完候補を自動で補完
setopt auto_param_keys       # カッコの対応などを自動的に補完
setopt magic_equal_subst     # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる

setopt complete_in_word      # 語の途中でもカーソル位置で補完
setopt always_last_prompt    # カーソル位置は保持したままファイル名一覧を順次その場で表示

setopt print_eight_bit
setopt extended_glob
setopt globdots

zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{yellow}%d%f'
zstyle ':completion:*:warnings' format '%F{red}No matches for:%f'' %F{yellow}%d%f'
zstyle ':completion:*:descriptions' format '%F{yellow}completing %B%d%b%f'
zstyle ':completion:*:corrections' format '%F{yellow}%B%d%f %F{red}(errors: %e)%b%f'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
# グループ名に空文字列を指定すると，マッチ対象のタグ名がグループ名に使われる。
# したがって，すべての マッチ種別を別々に表示させたいなら以下のようにする
zstyle ':completion:*' group-name ''
# color
# 30:black, 31:red, 32:green, 33:yellow, 34:blue, 35:paple, 36:cian, 37:white
#autoload predict-on
#predict-on

# precmd () {
#  PROMPT=$'%{\e[0;36m%}%* ['$( tty )$'] %%%{\e[m%} '
    # PROMPT=$'%{\e[0;36m%}%* [%m:%l] %%%{\e[m%} '
# }
 #PROMPT=$'%{\e[0;36m%}%* [%n@%m:%l] %%%{\e[m%} '
# PROMPT='[%F{032}%n%f@%F{036}%m%f: %F{064}%l%f]
# %F{172}%*%f $ '
# RPROMPT=$'%{\e[32m%}%/%{\e[m%}'
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' formats '(%F{green}%b%f)'
zstyle ':vcs_info:*' actionformats '(%F{green}%b%f(%F{red}%a%f)'
precmd() {
    vcs_info
}
#PROMPT='#%F{172}%D %*%f | %F{032}%n%f@%F{036}%m%f:%F{064}%l%f in %F{104}%~/%f ${vcs_info_msg_0_}
PROMPT=$'#%{\e[38;5;172m%}%D %*%{\e[m%} | %{\e[38;5;032m%}%n%{\e[m%}@%{\e[38;5;036m%}%m%{\e[m%}:%{\e[38;5;064m%}%l%{\e[m%} in %{\e[38;5;104m%}%~/%{\e[m%} ${vcs_info_msg_0_}
$ '
# RPROMPT='%F{104}%~/%f${vcs_info_msg_0_}'

[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
	  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}";

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history
setopt auto_cd
setopt auto_list
setopt auto_pushd
setopt correct
setopt no_beep
#setopt transient_rprompt
setopt prompt_subst
setopt pushd_ignore_dups
setopt list_packed
setopt list_types
setopt hist_ignore_dups
setopt EXTENDED_HISTORY


zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

alias ls="gls -pFl --color"
alias subl="/Applications/Sublime\ Text\.app/Contents/SharedSupport/bin/subl"
alias eclimd="/Applications/eclipse/eclimd"
alias pypy="~/Downloads/pypy-1.9/bin/pypy"
alias pypip="~/Downloads/pypy-1.9/bin/pip"
#alias dali="ssh dali.ht.sfc.keio.ac.jp"
typeset -U path cdpath fpath manpath

export EDITOR=vim
export HOSTNAME=`hostname`
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export TZ=JST-9
#export PATH=/opt/local/bin:/opt/local/sbin:/opt/local/libexec/gnubin:/usr/local/bin:/usr/local/sbin:$PATH
export MANPATH=$MANPATH:/opt/local/share/man
export LSCOLORS=cxdxcxdxbxegedabagacad
export MYSQLPATH=/opt/local/lib/mysql5/bin
export PATH=/usr/local/bin:/opt/local/bin:/opt/local/sbin:/opt/local/libexec/gnubin:$PATH
export PATH=$PATH:/Applications/android-sdk-macosx/tools
export PATH=$PATH:$HOME/.rvm/bin:/Applications/UpTeX.app/teTeX/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
# golang
#export GOPATH=$HOME/Documents/programming/gocode
export GOPATH=$HOME/go
#export GOROOT=`go env GOROOT`
export PATH=$PATH:$GOPATH/bin
export PATH=/usr/local/cuda/bin:$PATH
export DYLD_FALLBACK_LIBRARY_PATH=/usr/local/cuda/lib:/usr/local/lib:/usr/lib:/Developer/NVIDIA/CUDA-6.5/lib:$DYLD_FALLBACK_LIBRARY_PATH
eval $(gdircolors ~/config/dircolors-solarized/dircolors.ansi-universal)

#source /Users/makora/.pythonbrew/etc/bashrc
#[[ -s "$HOME/.pythonbrew/etc/bashrc" ]] && source "$HOME/.pythonbrew/etc/bashrc"
# The next line updates PATH for the Google Cloud SDK.
source '/Users/makora/google-cloud-sdk/path.zsh.inc'
# The next line enables bash completion for gcloud.
source '/Users/makora/google-cloud-sdk/completion.zsh.inc'

export PYTHONPATH=$HOME/caffe/python:$PYTHONPATH
export GEOS_DIR=/usr/local/Cellar/gdal/1.11.1_3/
export PATH=/Users/makora/torch/install/bin:$PATH
export LD_LIBRARY_PATH=/Users/makora/torch/install/lib:$LD_LIBRARY_PATH
export DYLD_LIBRARY_PATH=/Users/makora/torch/install/lib:$DYLD_LIBRARY_PATH

export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
export PATH=${PYENV_ROOT}/bin:${PYENV_ROOT}/shims:$PATH
eval "$(pyenv init -)"
fi

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-material.dark.sh"
#BASE16_SHELL="$HOME/.config/base16-shell/base16-tomorrow.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
