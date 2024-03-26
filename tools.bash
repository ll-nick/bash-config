# Virtualenv
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# Thefuck
eval $(thefuck --alias)

#z
source ~/.config/z/z.sh

# fzf
source /usr/share/doc/fzf/examples/key-bindings.bash
source /usr/share/doc/fzf/examples/completion.bash

if [ "$ENABLE_MRT_CONFIG" = true ]; then
  function mrtf {
    local cmd
    cmd=$(mrt --list | fzf | sed 's/\ \ \ .*//') &&
    bind '"\e[0n": "'"$cmd"'"' &&
    printf '\e[5n'
  }
fi

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Convenience functions
open() { for f in "$@"; do xdg-open "$f"; done; }
connect_ros() {
  if [ $# -ne 1 ]; then
    echo "Usage: connect_ros <hostname>"
    return 1
  fi

  export ROS_MASTER_URI="http://$1:11311"
}

