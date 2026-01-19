# Displaying instructions about optional script configurations
echo -e "[IMPORTANT INSTRUCTIONS -- PLEASE READ]\n"
echo -e "The script recommends creating and including the following optional configuration directories/files in some cases:\n"
echo -e "1. An optional Microsoft fonts directory called \"microsoft\" in the path \"./global/general/fonts/microsoft\".\n"
echo -e "-> If you wish to install Microsoft fonts, provide all the desired .ttf files in this directory.\n"
echo -e "-> If the directory is not provided, the script will simply ignore this.\n"
echo -e "2. An optional text file called \"trusted-connections-list.txt\" containing a list of"
echo -e "trusted connection profile names (one per line) in the path \"./global/general/configurations/trusted-connections-list.txt\".\n"
echo -e "-> This file will be used for firewall and DNS/IPv6 hardening to apply the trusted zone and its allowed services to trusted network connections.\n"
echo "-> If the file is not provided, the script will simply ignore DNS/IPv6 configuration and apply restrictive firewall rules"
echo -e "to all network interfaces (will break over-the-LAN apps and services).\n"
echo "-> To harden the network configuration and avoid potential LAN problems, please first connect to all networks you trust (*),"
echo -e "optionally renaming their connection profiles so they are easy to identify.\n"
echo -e "* To connect to Wi-Fi from CLI:\n"
echo -e "-> List nearby Wi-Fi networks: nmcli device wifi list\n"
echo -e "-> Connect to a specific SSID: sudo nmcli device wifi connect \"<SSID>\" password \"<PASSWORD>\"\n"
echo -e "-> To see current connection names: nmcli connection show\n"
echo -e "-> To change current connection names: sudo nmcli connection modify \"<CURRENT-NAME>\" con-name \"<NEW-NAME>\"\n"

echo -e "$line_separator\n"
read -rp "Would you like to exit the script now to go create these directories/files? [Y/n] " exit_script
echo -e "\n$line_separator"

if [[ ! "$exit_script" =~ ^[Nn]$ ]]; then
    echo -e "\nGreat! Please go create the directories/files and run the script again. Exiting..."
    exit
fi
