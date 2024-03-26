# Very hacky way to open terminator instead of gnome-terminal when using
# nautilus context menu. Copied from here: https://askubuntu.com/a/932969
# "If mildly insane in principle, this works flawlessly in practice"
if ps -o cmd= -p $(ps -o ppid= -p $$) | grep -q gnome; then
  nohup terminator &> /dev/null &
  sleep 0.1s
  exit
fi

