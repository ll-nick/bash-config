# ~/.bashrc: executed by bash(1) for non-login shells.
# Launch like PROFILE_BASH_STARTUP=true bash to profile startup time

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return ;;
esac

timed_source() {
    local file="$1"
    local start_time
    local end_time
    local elapsed_time
    local ns_per_ms=1000000

    start_time=$(date +%s%N)

    source "$file"

    end_time=$(date +%s%N)
    elapsed_time=$(((end_time - start_time) / ns_per_ms))

    echo "Loaded $file in ${elapsed_time}ms"
}

# Determine whether to use timed or normal sourcing
source_function="source"
if [[ -n "$PROFILE_BASH_STARTUP" ]]; then
    source_function="timed_source"
fi

# Source all non-hidden files in ~/.config/bash
for config_file in ~/.config/bash/*; do
    if [[ -f "$config_file" && "$(basename "$config_file")" != ".*" ]]; then
        $source_function "$config_file"
    fi
done
