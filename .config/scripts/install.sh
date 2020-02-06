echo "installing my dotfiles"

fetchFiles() {
  git clone --bare https://github.com/njohnsoncpe/dotties.git $HOME/.dotfiles > /dev/null 2>&1 
}

ask() {
  # https://djm.me/ask
  local prompt default reply

  if [ "${2:-}" = "Y" ]; then
    prompt="Y/n"
    default=Y
  elif [ "${2:-}" = "N" ]; then
    prompt="y/N"
    default=N
  else
    prompt="y/n"
    default=
  fi

  while true; do

    # Ask the question (not using "read -p" as it uses stderr not stdout)
    echo -n "$1 [$prompt] "

    # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
    read reply </dev/tty

    # Default?
    if [ -z "$reply" ]; then
      reply=$default
    fi

    # Check if the reply is valid
    case "$reply" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac

  done
}

function whichShell {
  local shl
  local cmd

  shl="$(basename $SHELL)"
  cmd="alias config=\"/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME\""
  echo -n "looks like you're using "
  case $shl in

    bash)
      echo "bash"
      echo "$cmd" >> $HOME/.bashrc
      ;;

    zsh)
      echo "zsh"
      echo "$cmd" >>$HOME/.zshrc
      ;;

    *)
      echo -n "$shl"
      echo ", a shell my dotfiles aren't tested on."
      if ask "Do you want to continue?" N; then

        echo -e "Copy this alias into your rc file\n"
        echo "$cmd"
        echo -e "\n===USE AT YOUR OWN RISK==="
      else
        exit 1
      fi
  esac
}

fetchFiles
if [[ $? -eq 128 ]]; then
  echo "You already have my dotfiles! "
else

  local config

  whichShell
  echo ".dotfiles" >> .gitignore
  local config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
  mkdir -p .config-backup
  config checkout
  if [ $? = 0 ]; then
    echo "checked out config"
  else
    echo "backing up previous config"
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
  fi;
  config checkout
  config config --local status.showUntrackedFiles no
fi
