export PATH=$PATH:./node_modules/.bin
export PATH=$PATH:/Users/kazuya/.mos/bin
export PATH=$PATH:/Users/nonakanaoki/Library/Android/sdk/platform-tools
#export PATH="/Applications/MacVim.app/Contents/MacOS:$PATH"
alias posSQL='cd /Library/PostgreSQL/9.5/scripts/; ./runpsql.sh'
alias softWD='cd /Users/kazuya/softwareDesign/Windows/src'
alias startpos='pg_ctl start'
alias stoppos='pg_ctl stop'
alias pyrun='python manage.py runserver'
alias gitlog='git log --graph --decorate --all'
#------------------------------
# General Settings
# ------------------------------
export EDITOR=vim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=u           # KCODEにUTF-8を設定
export AUTOFEATURE=true  # autotestでfeatureを動かす

bindkey -e               # キーバインドをemacsモードに設定
# bindkey -v              # キーバインドをviモードに設定

setopt no_beep           # ビープ音を鳴らさないようにする
setopt auto_cd           # ディレクトリ名の入力のみで移動する
cdpath=(.. ~ ~/Desktop/CPS)
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
setopt correct           # コマンドのスペルを訂正する
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify            # バックグラウンドジョブの状態変化を即時報告する
setopt equals            # =commandを`which command`と同じ処理にする

#glabの問題を勝手にエスケープしてくれる
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

### Complement ###
fpath=(/usr/local/share/zsh-completions $fpath) #for zsh-completions
autoload -Uz compinit; compinit -u  # 補完機能を有効にする
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない

### Glob ###
setopt extended_glob # グロブ機能を拡張する
unsetopt caseglob    # ファイルグロブで大文字小文字を区別しない

### History ###
HISTFILE=~/.zsh_history   # ヒストリを保存するファイル
HISTSIZE=10000            # メモリに保存されるヒストリの件数
SAVEHIST=10000            # 保存されるヒストリの件数
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history   # ヒストリに実行時間も保存する
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する

# マッチしたコマンドのヒストリを表示できるようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# すべてのヒストリを表示する
function history-all { history -E 1 }


# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

### Prompt ###
# プロンプトに色を付ける
autoload -U colors; colors
# 一般ユーザ時
tmp_prompt="%{${fg[cyan]}%}%n%# %{${reset_color}%}"
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト
# SSHログイン時のプロンプト
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
;

### Title (user@hostname) ###
# case "${TERM}" in
# kterm*|xterm*|)
#   precmd() {
#     echo -ne "\033]0;${USER}@${HOST%%.*}\007"
#   }
#   ;;
# esac


# ------------------------------
# Other Settings
# ------------------------------
### RVM ###
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

### Macports ###
case "${OSTYPE}" in
  darwin*)
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
    export MANPATH=/opt/local/share/man:/opt/local/man:$MANPATH
  ;;
esac


# cdコマンド実行後、lsを実行する
#function cd() {
#  builtin cd $@ && ls;
#}

### Aliases ###
alias cl=clear
alias la='ls -a'
alias ll='ls -l'
alias l1='ls -1'
alias pingoo='ping www.google.com'
alias twimdl='python3 PycharmProjects/TwitterUtilities/ImageDownloader/ImageDownloader.py'
alias avrobj='/Applications/Arduino.app/Contents/Resources/Java/hardware/tools/avr/bin/avr-objdump'

##pecoの設定##
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

#zshでvimのモードを表示

# function zle-line-init zle-keymap-select {
#   case $KEYMAP in
#       vicmd)
#           PROMPT="%{$fg[green]%}[%{$reset_color%}%n/%{$fg_bold[red]%}NOR%{$reset_color%}%{$fg[green]%}]%#%{$reset_color%} "
#           ;;
#           main|viins)
#               PROMPT="%{$fg[green]%}[%{$reset_color%}%n/%{$fg_bold[cyan]%}INS%{$reset_color%}%{$fg[green]%}]%#%{$reset_color%} "
#               ;;
#             esac
#           zle reset-prompt
#       }
#       zle -N zle-line-init
#       zle -N zle-keymap-select
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"


#VCSの情報を表示する
# この行は現在のパスを表示する設定です。ブランチを表示して色をつける設定とは関係ありません
RPROMPT="%{${fg[cyan]}%}[%~]%{${reset_color}%}"

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'


# for virtualenv python2
# export WORKON_HOME=$HOME/.virtualenvs
# source /usr/local/bin/virtualenvwrapper.sh
export PATH=$HOME/.nodebrew/current/bin:$PATH
