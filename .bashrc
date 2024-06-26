# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Source all non-hidden files in ~/.config/bash
for config_file in ~/.config/bash/*; do
  if [[ -f "$config_file" && "$(basename "$config_file")" != ".*" ]]; then
    source "$config_file"
  fi
done

