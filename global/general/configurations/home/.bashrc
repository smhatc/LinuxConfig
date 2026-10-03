# This file is read each time an interactive shell is started and is also sourced by login shells
# All login shells will read ".bash_profile" instead

#########################
### STARTING PROGRAMS ###
#########################

# Starship prompt and Fastfetch for non-login shells (not in TTY, also Fastfetch only in "kitty" terminal)
if ! shopt -q login_shell; then
    [[ -f "$(command -v starship)" ]] && eval "$(starship init bash)"
    [[ -f "$(command -v fastfetch)" ]] && [[ "$TERM" == "xterm-kitty" ]] && [[ "$(tput cols)" -ge 130 ]] && [[ "$(tput lines)" -ge 30 ]] && fastfetch
fi

#####################################
### SETTING ENVIRONMENT VARIABLES ###
#####################################

# PATH variable
if ! [[ "$PATH" =~ $HOME/.local/bin:$HOME/bin: ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
    export PATH
fi

#######################
### SETTING ALIASES ###
#######################

# General commands
alias "cls"="clear"
alias ".."="cd .."
alias "..."="cd ../.."
alias "...."="cd ../../.."
alias "lla"="ls -A"
alias "lll"="ls -Alh"
alias "lst"="tree"

# Package management commands
alias "fse"="flatpak search"
alias "fin"="sudo --preserve-env=XDG_DATA_DIRS flatpak install"
alias "fup"="sudo --preserve-env=XDG_DATA_DIRS flatpak update -y"
alias "frm"="sudo --preserve-env=XDG_DATA_DIRS flatpak uninstall --delete-data"
alias "frmwod"="sudo --preserve-env=XDG_DATA_DIRS flatpak uninstall"

alias "zse"="zypper --no-refresh se"
alias "zrf"="sudo zypper ref"
alias "zin"="sudo zypper --no-refresh in"
alias "zinwor"="sudo zypper --no-refresh in --no-recommends"
alias "zup"="sudo zypper dup -y"
alias "zrm"="sudo zypper --no-refresh rm -u"
alias "zrmwod"="sudo zypper --no-refresh rm"

# Distrobox commands
alias "dsbl"="distrobox ls"
alias "dsbc"="distrobox create"
alias "dsba"="distrobox assemble"
alias "dsbu"="distrobox upgrade -a"
alias "dsbe"="distrobox enter"
alias "dsbs"="distrobox stop"
alias "dsbr"="distrobox rm"
alias "dsbf"="distrobox ephemeral"

# Hyprland commands
alias "sth"="start-hyprland >/dev/null 2>&1"
alias "hyprlock-restore"="~/.config/waybar/scripts/session.sh restore-lock"

# Programs
alias "n"="nano"
alias "c"="code"

#########################
### SETTING FUNCTIONS ###
#########################

# Run backup script
bkup() {
    local backup_dir="$HOME/My Files/Digital Roots/Linux Setup/LinuxBackup"
    local backup_script="backup.sh"
    [[ -x "${backup_dir}/${backup_script}" ]] && cd "$backup_dir" && ./"$backup_script"
}

# Update system based on which package managers are installed
up() {
    [[ -f "$(command -v flatpak)" ]] && fup
    [[ -f "$(command -v distrobox)" ]] && dsbu
    [[ -f "$(command -v zypper)" ]] && zrf && zup
}
