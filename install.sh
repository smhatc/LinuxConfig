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

# Using "/etc/os-release" file as a standard method to automate distribution detection
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

# Set list of desktop environment options plus path to setup file based on the detected distribution
if [[ "$distro" == "openSUSE Tumbleweed" ]]; then
    desktop_choices+=("Hyprland")
    setup_file="./opensuse-tumbleweed/setup.sh"
fi

# Prompt the user to select a specific desktop environment from the list
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
