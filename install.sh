#!/bin/bash

##############################################
### DEFINING GENERAL VARIABLES & FUNCTIONS ###
##############################################

# Output formatting variables
process_icon=" >"
error_icon="(!)"
success_icon="(√)"
line_separator="--------------------------------------------------"
line_separator_small="-------------------------"

# Script options
distro=""
desktop=""
desktop_choices=()

# Functions
desktop_selection() {
    local setup_file=$1
    echo "${process_icon} The following desktop environment choices are available for \"${distro}\", please select one:"
    select choice in "${desktop_choices[@]}"; do
        if [[ -n "$choice" ]]; then
            desktop="$choice"
            echo "${success_icon} Selected \"${desktop}\" for your \"${distro}\" installation." && source "$setup_file"
            break
        else
            echo "${error_icon} Invalid selection, please try again."
        fi
    done
}

general_instructions() {
    echo -e "[IMPORTANT -- PLEASE READ]\n"
    echo -e "The script makes the following general assumptions about your installation environment:\n"
    echo -e "1. An optional Microsoft fonts directory called \"microsoft\" in the path \"./global/general/fonts/microsoft\".\n"
    echo -e "-> If you wish to install Microsoft fonts, provide all the desired .ttf files in this directory.\n"
    echo -e "-> If the directory is not provided, the script will simply ignore this.\n"
    echo "$line_separator"
    echo -e "\n2. An optional text file called \"trusted-connections-list.txt\" containing a list of"
    echo -e "trusted connection profile names (one per line) in the path \"./global/general/configurations/trusted-connections-list.txt\".\n"
    echo -e "-> This file will be used for firewall and DNS/IPv6 hardening to apply the trusted zone and its allowed services to trusted network connections.\n"
    echo "-> If the file is not provided, the script will simply ignore DNS/IPv6 configuration and apply restrictive firewall rules"
    echo -e "to all network interfaces (will break over-the-LAN apps and services).\n"
    echo "-> To harden the network configuration and avoid potential LAN problems, please first connect to all networks you trust (*),"
    echo -e "optionally renaming their connection profiles so they are easy to identify.\n"
    echo "$line_separator"
    echo -e "\n* To connect to Wi-Fi from CLI:\n"
    echo -e "-> List nearby Wi-Fi networks: nmcli device wifi list\n"
    echo -e "-> Connect to a specific SSID: sudo nmcli device wifi connect \"<SSID>\" password \"<PASSWORD>\"\n"
    echo -e "-> To see current connection names: nmcli connection show\n"
    echo -e "-> To change current connection names: sudo nmcli connection modify \"<CURRENT-NAME>\" con-name \"<NEW-NAME>\""
}

##############################
### DETECTING DISTRIBUTION ###
##############################

echo -e "\n##############################"
echo '### DETECTING DISTRIBUTION ###'
echo -e "##############################\n"

echo "${process_icon} Starting distribution detection..."

if [[ -f /etc/os-release ]]; then
    source /etc/os-release
    if [[ "$ID" == "opensuse-tumbleweed" ]]; then
        distro="openSUSE Tumbleweed"
        echo "${success_icon} Distribution detected as \"${distro}\"."
    else
        echo "${error_icon} Unknown distribution detected (${NAME}). The script does not know how to handle setting up this system. Exiting..."
        exit
    fi
else
    echo "${error_icon} Cannot detect distribution. The \"/etc/os-release\" file could not be found. Exiting..."
    exit
fi

######################################
### CHOOSING DESKTOP CONFIGURATION ###
######################################

echo -e "\n######################################"
echo '### CHOOSING DESKTOP CONFIGURATION ###'
echo -e "######################################\n"

if [[ "$distro" == "openSUSE Tumbleweed" ]]; then
    desktop_choices+=("Hyprland")
    desktop_selection ./opensuse-tumbleweed/setup.sh
fi
