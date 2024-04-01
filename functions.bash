open() { for f in "$@"; do xdg-open "$f"; done; }

connect_ros() {
  if [ $# -ne 1 ]; then
    echo "Usage: connect_ros <hostname>"
    return 1
  fi

  export ROS_MASTER_URI="http://$1:11311"
}

