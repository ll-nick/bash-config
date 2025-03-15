#!/bin/bash

update-all() {
    UPDATE_TIMESTAMP="$HOME/.last_update_time"
    local NO_CONFIRM=false

    PEACH="\033[38;2;250;179;135m"  # Catppuccin Mocha Peach
    BLUE="\033[38;2;116;199;236m"  # Catppuccin Mocha Blue
    RESET="\033[0m"

    # Check for --no-confirm argument
    for arg in "$@"; do
        if [[ "$arg" == "--yes" ]] || [[ "$arg" == "-y" ]]; then
            NO_CONFIRM=true
        fi
    done

    print_title() {
        TITLE="

 ██    ██ ██████  ██████   █████  ████████ ███████ ██████  
 ██    ██ ██   ██ ██   ██ ██   ██    ██    ██      ██   ██ 
 ██    ██ ██████  ██   ██ ███████    ██    █████   ██████  
 ██    ██ ██      ██   ██ ██   ██    ██    ██      ██   ██ 
  ██████  ██      ██████  ██   ██    ██    ███████ ██   ██ 

        "
        echo -e "${PEACH}$TITLE${RESET}"
    }

    print_section() {
        local title="$1"
        echo -e "\n ${BLUE}###############################################${RESET}"
        echo -e " ${BLUE}#${RESET}  \033[1;33m$title\033[0m"
        echo -e " ${BLUE}###############################################${RESET}\n"
    }

    print_message() {
        local type="$1"
        local message="$2"

        case "$type" in
            success) echo -e "\033[1;32m✔ $message\033[0m" ;;
            warning) echo -e "\033[1;33m⚠ $message\033[0m" ;;
            error)   echo -e "\033[1;31m❌ $message\033[0m" ;;
            *)       echo "$message" ;;
        esac
    }

    confirm_step() {
        local prompt_message="$1"
        if [ "$NO_CONFIRM" = false ]; then
            read -rp "$prompt_message (y/N): " response
            case "$response" in
                [yY][eE][sS]|[yY]) return 0 ;;
                *) echo "Skipping..."; return 1 ;;
            esac
        fi
        return 0
    }

    update_system() {
        print_section "Updating System Packages 📦"
        if command -v pacman &>/dev/null; then
            if confirm_step "Proceed with update of system packages via pacman?"; then
                sudo pacman -Syu --noconfirm
            fi
        elif command -v apt &>/dev/null; then
            if confirm_step "Proceed with update of system packages via apt?"; then
                sudo apt update && sudo apt upgrade -y
            fi
        else
            print_message error "No Supported Package Manager Found!"
        fi
    }

    update_dotfiles() {
        print_section "Updating Dotfiles 🛠️"
        if confirm_step "Update dotfiles via Ansible?"; then
            if command -v ansible-pull &>/dev/null; then
                ansible-pull -U https://github.com/ll-nick/ansible-config.git
            else
                print_message warning "⚠️ Ansible-pull not installed - Skipping!"
            fi
        fi
    }

    update_tmux() {
        print_section "Updating Tmux Plugins 🔧"
        if confirm_step "Update Tmux plugins?"; then
            if [ -d "$HOME/.config/tmux/plugins/tpm" ]; then
                ~/.config/tmux/plugins/tpm/bin/update_plugins all
            else
                print_message warning "⚠️ Tmux Plugin Manager (TPM) Not Found - Skipping!"
            fi
        fi
    }

    update_neovim() {
        print_section "Updating Neovim Plugins ✨"
        if confirm_step "Update Neovim plugins?"; then
            if command -v nvim &>/dev/null; then
                nvim --headless "+Lazy update" +qa
            else
                print_message warning "⚠️ Neovim Not Found - Skipping!"
            fi
        fi
    }

    # Start update process
    print_title
    update_system
    update_dotfiles
    update_tmux
    update_neovim

    # Save timestamp
    date +%s > "$UPDATE_TIMESTAMP"
    print_section "✅ All Updates Completed!"
}

