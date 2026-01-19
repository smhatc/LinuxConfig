#!/bin/bash

##################################
### DEFINING GENERAL VARIABLES ###
##################################

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
setup_file=""

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
    setup_file="./opensuse-tumbleweed/setup.sh"
fi

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
