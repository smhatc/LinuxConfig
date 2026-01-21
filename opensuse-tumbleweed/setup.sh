#########################################
### SCRIPT ASSUMPTIONS & INSTRUCTIONS ###
#########################################

echo -e "\n#########################################"
echo '### SCRIPT ASSUMPTIONS & INSTRUCTIONS ###'
echo -e "#########################################\n"

source ./global/general/scripts/display-instructions.sh
[[ "$desktop" == "Hyprland" ]] && source ./opensuse-tumbleweed/hyprland/scripts/display-assumptions.sh

######################################
### INSTALLING SCRIPT DEPENDENCIES ###
######################################

echo -e "\n######################################"
echo '### INSTALLING SCRIPT DEPENDENCIES ###'
echo -e "######################################\n"

echo "${process_icon} Starting installation of script dependencies..."
source ./opensuse-tumbleweed/general/scripts/install-zypper-dependencies.sh && xdg-user-dirs-update
echo "${success_icon} Finished installation of script dependencies."

########################
### INSTALLING FONTS ###
########################

echo -e "\n########################"
echo '### INSTALLING FONTS ###'
echo -e "########################\n"

echo "${process_icon} Starting installation of fonts..."
source ./global/general/scripts/install-fonts.sh
echo "${success_icon} Finished installation of fonts."

##########################################################################
### INSTALLING NATIVE APPS, PATTERNS, DRIVERS, & CODECS (ZYPPER & OPI) ###
##########################################################################

echo -e "\n##########################################################################"
echo '### INSTALLING NATIVE APPS, PATTERNS, DRIVERS, & CODECS (ZYPPER & OPI) ###'
echo -e "##########################################################################\n"

echo "${process_icon} Starting installation of needed native apps, patterns, drivers, and codecs..."
sudo zypper ref
source ./opensuse-tumbleweed/general/scripts/install-zypper-patterns.sh
source ./opensuse-tumbleweed/general/scripts/install-opi-apps.sh
source ./opensuse-tumbleweed/general/scripts/install-zypper-apps.sh
[[ "$desktop" == "Hyprland" ]] && source ./opensuse-tumbleweed/hyprland/scripts/install-zypper-apps.sh
echo "${success_icon} Finished installation of needed native apps, patterns, drivers, and codecs."

################################################
### INSTALLING NATIVE APPS (DIRECT DOWNLOAD) ###
################################################

echo -e "\n################################################"
echo '### INSTALLING NATIVE APPS (DIRECT DOWNLOAD) ###'
echo -e "################################################\n"

echo "${process_icon} Starting installation of native direct download applications..."
source ./global/general/scripts/install-direct-apps.sh
echo -e "\n${success_icon} Finished installation of native direct download applications."

####################################################
### UNINSTALLING UNNEEDED NATIVE APPS & PATTERNS ###
####################################################

echo -e "\n####################################################"
echo '### UNINSTALLING UNNEEDED NATIVE APPS & PATTERNS ###'
echo -e "####################################################\n"

echo "${process_icon} Starting uninstallation of unneeded native apps and patterns..."
source ./opensuse-tumbleweed/general/scripts/uninstall-zypper-patterns.sh
source ./opensuse-tumbleweed/general/scripts/uninstall-zypper-apps.sh
[[ "$desktop" == "Hyprland" ]] && source ./opensuse-tumbleweed/hyprland/scripts/uninstall-zypper-apps.sh
echo "${success_icon} Finished uninstallation of unneeded native apps and patterns."

###########################
### UPDATING THE SYSTEM ###
###########################

echo -e "\n###########################"
echo '### UPDATING THE SYSTEM ###'
echo -e "###########################\n"

echo "${process_icon} Starting system update..."
sudo zypper ref && sudo zypper dup -y
echo "${success_icon} Finished updating the system (reboot after script finishes to avoid problems)."

##################################################
### APPLYING SYSTEM/APPLICATION CONFIGURATIONS ###
##################################################

echo -e "\n##################################################"
echo '### APPLYING SYSTEM/APPLICATION CONFIGURATIONS ###'
echo -e "##################################################\n"

echo -e "${process_icon} Applying configurations...\n"
source ./global/general/scripts/configure-users-groups.sh
echo "$line_separator"
source ./global/general/scripts/configure-services.sh
echo "$line_separator"
[[ "$desktop" == "Hyprland" ]] && source ./global/hyprland/scripts/configure-services.sh
echo "$line_separator"
source ./global/general/scripts/configure-firewalld-netifs.sh
echo -e "\n${success_icon} Finished applying configurations."

#########################################
### INSTALLING FLATPAK APPS (FLATHUB) ###
#########################################

echo -e "\n#########################################"
echo '### INSTALLING FLATPAK APPS (FLATHUB) ###'
echo -e "#########################################\n"

echo "${process_icon} Adding Flathub repository and installing needed Flatpak apps..."
source ./global/general/scripts/add-flathub.sh
source ./global/general/scripts/install-flatpak-apps.sh
echo "${success_icon} Finished adding Flathub repository and installing needed Flatpak apps."

################################
### HALT FOR REVIEW & REBOOT ###
################################

echo -e "\n################################"
echo '### HALT FOR REVIEW & REBOOT ###'
echo -e "################################\n"

read -rp "Would you like to automatically reboot the system now? [Y/n] " reboot_now

if [[ ! "$reboot_now" =~ ^[Nn]$ ]]; then
    systemctl reboot
else
    exit
fi
