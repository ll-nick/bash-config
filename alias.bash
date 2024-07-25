alias auau="sudo apt update && sudo apt upgrade"
alias coredumps="ls -d /var/lib/apport/coredump/*"
alias enable_coredumps="ulimit -c unlimited && echo 'core.%e.%p.%h.%t' | sudo tee /proc/sys/kernel/core_pattern"
alias screencastkeys="screenkey --no-detach -m --scr 1"
alias update-config="ansible-pull -U https://github.com/ll-nick/ansible-config.git"
alias update-config-privileged="ansible-pull -U https://github.com/ll-nick/ansible-config.git --tags all,privileged -K"

