#!/bin/env zsh
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
DEFAULT_USER=$(whoami)
# Path to your oh-my-zsh installation.
#export ZSH="$HOME/.oh-my-zsh"

# Load Antigen
source ~/.config/antigen.zsh


# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle sudo
antigen bundle conda-zsh-completion
antigen bundle pip
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle vi-mode

# Load the theme.
antigen theme romkatv/powerlevel10k
# Tell Antigen that you're done.
antigen apply

POWERLEVEL9K_MODE="awesome-patched"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs anaconda time)
POWERLEVEL9K_ANACONDA_LEFT_DELIMITER=""
POWERLEVEL9K_ANACONDA_RIGHT_DELIMITER=""
COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#93a1a1"
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=100000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.
# User configuration

setopt CORRECT

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# Compilation flags
# export ARCHFLAGS="-arch x86_64"
iatest=$(expr index "$-" i)
# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac
#Editor Env Variables
#Editor is for Terminal
export EDITOR='/usr/bin/nvim'
#Visual o/w
export VISUAL='/usr/bin/nvim'
# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color|*-256color) color_prompt=yes;;
esac
# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi
unset color_prompt force_color_prompt
if [ -x /usr/bin/dircolors ]; then
  test -r $HOME/.dircolors && eval "$(dircolors -b $HOME/.dircolors)" || eval "$(dircolors -b)"
fi
# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# Make sure we can access scripts directory
if [[ -d $HOME/.config/scripts ]]; then
  export PATH="$HOME/.config/scripts:$PATH"

  source $HOME/.config/scripts/fzf-tools
  source $HOME/.config/scripts/generalFunctions
else
  echo "scripts directory missing, functionality will be greatly reduced"
fi

# Alias definitions. must be sourced AFTER generalFunctions 
[[ -f $HOME/.config/aliasrc ]] && source $HOME/.config/aliasrc

# symlinks.
if [ -d "$HOME/.config/symlinks" ]; then
  export PATH="$HOME/.config/symlinks:$PATH"
fi

export JAVA_HOME
PATH=$PATH:$JAVA_HOME
export PATH
#Matlab Path append

export PATH="/usr/local/MATLAB/R2019b/bin:$PATH"

#getPkgMan #TODO: get this script working

#go-lang
#if [[ $(which go) = *"not found"* ]]; then
#  if ask "Go not installed, install now?" N; then
#    pkgInstall go
#  fi
#else
#  export GOPATH=$HOME/gocode
#  export PATH=$PATH:$(go env GOPATH)/bin
#  export GOPATH=$(go env GOPATH)
#fi

[[ -d "/usr/lib/jvm/" ]] && export JAVA_HOME="/usr/lib/jvm/java-8-oracle/"

#Tensorflow Source Builds

[[ -d "$HOME/tensorflow_builds" ]] && export tfcputools=$HOME/tensorflow_builds/tf_cpu/tensorflow/bazel-bin/tensorflow/tools && export tfgputools=$HOME/tensorflow_builds/tf_gpu/tensorflow/bazel-bin/tensorflow/tools

#CUDNN
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64"
export CUDA_HOME="/usr/local/cuda/"
export PATH="$PATH:/usr/local/cuda/bin"

# Used for comprehensive logging
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> $HOME/.logs/zsh-history-$(date "+%Y-%m-%d").log; fi'
setopt auto_cd

# Update LINES and COLUMNS after each command if necessary
# Include filenames with leading dots in pattern matching
setopt dotglob
# Load history expansion result as the next command, don't run them directly
setopt histverify
# some usefull functions

export CUDA_HOME=/usr/local/cuda

# Runs a ls immediately when you're inside a file.

if [ ! -z "$LOAD_ROS_ENV" ] ; then
  source /opt/ros/melodic/setup.bash
  source $HOME/catkin_ws/devel/setup.bash
  export LD_LIBRARY_PATH=/usr/local/lib:$HOME/catkin_ws/devel/lib:/opt/ros/melodic/lib:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64
  source /usr/share/gazebo/setup.sh
fi


#comprehensive logs
if [ ! -d "$HOME/.logs" ]; then
  mkdir $HOME/.logs
fi
export LOGPATH=$HOME/.logs

export ANACONDA_PATH="$HOME/anaconda3/"


if [ -d $ANACONDA_PATH ]; then
  # >> conda initialize>>
  # # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$("$ANACONDA_PATH/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    if [ -f "$ANACONDA_PATH/etc/profile.d/conda.sh" ]; then
      . "$ANACONDA_PATH/etc/profile.d/conda.sh"
    else
      export PATH="$HOME/anaconda3/bin:$PATH"
    fi
  fi
  unset __conda_setup
  # <<  conda initialize<<
fi

#better binary calculator setup
[[ -f $HOME/.config/bcrc ]] && export BC_ENV_ARGS=$HOME/.config/bcrc
#Chezmoi Aliases
export CHEZMOI_PATH=$HOME/.local/share/chezmoi

#Chezmoi Aware Edit sh function because I keep forgetting to edit the chezmoi files using "chezmoi edit" instead of just editing the local copies.

hostname=$(hostname -f)
if [ "$hostname" = "noahserver.ele.uri.edu" ]; then
  #Task Warrior server
  export TASKDDATA=/var/taskd
  [ ! -d "$TASKDDATA" ] && sudo mkdir -p $TASKDDATA;
fi

# source $HOME/.bashrc.task
[[ -f $HOME/.config/zhstrconf ]] && source $HOME/.config/zhstrconf
[[ -f $HOME/.config/p10k.zsh ]] && source $HOME/.config/p10k.zsh
POWERLEVEL9K_COLOR_SCHEME='light'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
