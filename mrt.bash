if [ "$ENABLE_MRT_CONFIG" != true ]; then
    return
fi

source /opt/mrtsoftware/setup.bash
source /opt/mrtros/setup.bash

alias codews='code $(mrt catkin locate)'
alias kitvpn='sudo openvpn --config ~/Documents/kit.ovpn'
alias mensa='kit-mensa-cli'
alias rf='rosbag_fancy'
