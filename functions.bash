open() { for f in "$@"; do xdg-open "$f"; done; }

connect-ros() {
  if [ $# -ne 1 ]; then
    echo "Usage: connect_ros <hostname>"
    return 1
  fi

  export ROS_MASTER_URI="http://$1:11311"
}

git-ssh() {
    local remote=${1:-origin}
    local current_url
    current_url=$(git remote get-url "$remote")
    local new_url
    new_url=$(echo "$current_url" | sed -E 's,^https://([^/]*)/(.*)$,git@\1:\2,')
    git remote set-url "$remote" "$new_url"
    echo "Changed remote $remote to $new_url"
}

git-https() {
    local remote=${1:-origin}
    local current_url
    current_url=$(git remote get-url "$remote")
    local new_url
    new_url=$(echo "$current_url" | sed -E 's,^git@([^:]*):/*(.*)$,https://\1/\2,')
    git remote set-url "$remote" "$new_url"
    echo "Changed remote $remote to $new_url"
}

