# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

[[ -z "$TMUX" && -n "$USE_TMUX" ]] && {
    [[ -n "$ATTACH_ONLY" ]] && {
        tmux a 2>/dev/null || {
            cd && exec tmux
        }
        exit
    }

    tmux new-window -c "$PWD" 2>/dev/null && exec tmux a
    exec tmux
    # exec ~/.tmux/plugins/tmux-logging/scripts/start_logging.sh
}
# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# if [[ $TERM="screen" ]] && [[ $(ps -p $PPID -o comm=)="tmux" ]]; then
#   mkdir $HOME/.xtermlogs 2> /dev/null
#   logname="$(date -u +%Y-%m-%d_%H-%M-%S)_${HOSTNAME}.tmux.log"
#   script -f $HOME/.xtermlogs/${logname}
#   exit
# fi

# Log Xterm commands
# mkdir -p ~/.xtermlogs
# if [ $(ls ~ | grep Xterm | wc -l) -gt 0 ]; then
#   mv ~/Xterm.log.* ~/.xtermlogs 2>/dev/null
# fi

# find ~/.xtermlogs/ -daystart -mtime +6 -not -name "*.gz" -exec ~/remove_nonansi_inplace.pl {} \; -exec gzip {} \;
#
eval `dircolors ~/.dircolors/dircolors.ansi-universal`

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="agnoster-min"

plugins=(git compleat tmuxinator z github extract battery themes shrink-path)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

#source ~/.oh-my-zsh/oh-my-zsh.sh

[ -z "$TMUX" ] && export TERM=xterm-256color


HISTSIZE=50000
SAVEHIST=50000
# HISTFILE="/home/danielb/history/$(date -u +%Y-%m-%d_%H-%M-%S)_${HOSTNAME}_$$"; export HISTFILE
#
# source files from rc.d
# from: https://github.com/jcorbin/home/blob/master/.zshrc
source ~/.zsh/rc.d

# Completion settings
fpath=(~/.zsh/completion $fpath)

# compsys initialization
autoload -U compinit && compinit
zmodload -i zsh/complist

################################################################################
# Aliases
################################################################################
alias con="tail -40 -f /var/log/system.log"
alias ls="ls -lahL"
alias uxtermlog="uxterm -l"
alias R="ranger"

################################################################################
# Environment variables
################################################################################
export DISPLAY=:0
export TERM=xterm-256color
export PAGER="nvim -c 'set ft=man' -"
# export PAGER='less'
export GIT_EDITOR='nvim -u NONE'
export EDITOR='nvim'
export VISUAL='nvim'
# export LANG="hu_HU.UTF-8"
# export LC_COLLATE="hu_HU.UTF-8"
# export LC_CTYPE="hu_HU.UTF-8"
# export LC_MESSAGES="hu_HU.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
# export LC_MONETARY="hu_HU.UTF-8"
# export LC_NUMERIC="hu_HU.UTF-8"
# export LC_TIME="hu_HU.UTF-8"
# export LC_ALL="hu_HU.UTF-8"

# 10 second wait if you do something that will delete everything.  I wish I'd had this before...
setopt RM_STAR_WAIT

# Who doesn't want home and end to work?
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

################################################################################
# vi-mode prompt display setup
################################################################################
# function zle-line-init zle-keymap-select() {
#   zle reset-prompt
#   zle -R
# }

# # # zle -N zle-line-init
# zle -N zle-line-init
# zle -N zle-keymap-select
# zle -N edit-command-line

# if [[ "$NRM_INDICATOR" == "" ]]; then
#   NRM_INDICATOR="%{$bg[green]%}%{$fg[black]%}NRM%{$reset_color%}"
# fi

# if [[ "$INS_INDICATOR" == "" ]]; then
#   INS_INDICATOR="%{$bg[blue]%}%{$fg[black]%}INS%{$reset_color%}"
# fi

# function vi_mode_prompt_info() {
#   echo "${${KEYMAP/vicmd/$NRM_INDICATOR}/(main|viins)/$INS_INDICATOR}"
# }

# if [[ "$RPS1" == "" && "$PROMPT" == "" ]]; then
#   RPS1='$(vi_mode_prompt_info)'
#fi

# from: http://superuser.com/questions/357107/zsh-right-justify-in-ps1
_newline=$'\n'
_lineup=$'\e[1A'
_linedown=$'\e[1B'

PROMPT=$PROMPT${_newline}" >>= "

# RPROMPT=%{${_lineup}%}'$(vi_mode_prompt_info) %* '%{${_linedown}%}
RPROMPT=%{${_lineup}%}'%* '%{${_linedown}%}

################################################################################
# vi-mode key setups
################################################################################
# bindkey -v
# KEYTIMEOUT=1

# it's like, space AND completion.  Gnarlbot.
# bindkey -M viins ' ' magic-space
# bindkey -M vicmd ' ' magic-space
bindkey -M isearch " " magic-space
bindkey ' ' magic-space

# bindkey -r '^P'
# bindkey '^P' up-history
# bindkey -r '^N'
# bindkey '^N' down-history

# bindkey '^?' backward-delete-char
# bindkey '^h' backward-delete-char

# bindkey '^w' backward-kill-word

# bindkey '^r' history-incremental-search-backward

# # Incremental search is elite!
# bindkey -M vicmd "/" history-incremental-search-backward
# bindkey -M vicmd "?" history-incremental-search-forward

# # # Search based on what you typed in already
# bindkey -M vicmd "//" history-beginning-search-backward
# bindkey -M vicmd "??" history-beginning-search-forward

# # # oh wow!  This is killer...  try it!
# bindkey -M vicmd "q" push-line
