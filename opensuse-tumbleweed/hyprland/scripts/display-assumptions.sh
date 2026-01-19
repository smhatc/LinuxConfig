echo -e "\n[ASSUMPTIONS CONFIRMATION -- PLEASE READ]\n"
echo -e "Because you have chosen to install \"${distro}\" with \"${desktop}\", the script assumes the following parameters were selected during OS installation:\n"
echo -e "1. Enabled repositories: OSS, NON-OSS, Updates.\n"
echo -e "2. System role: Server.\n"
echo -e "3. A user has been created (user creation not skipped).\n"
echo -e "4. The following pattern selection:\n"
echo -e "-> Basic: Help and Support Documentation, Base System, Enhanced Base System, SELinux Support, x86-64-v3 Libraries, Mobile, Software Management, Minimal Appliance Base.\n"
echo -e "-> Added (saves time): KVM Server/Tools, Fonts\n"
echo -e "-> Removed (saves time): YaST Base Utilities, YaST Server Utilities\n"

echo -e "$line_separator\n"
read -rp "Does your OS installation match the above description? [Y/n] " assumptions_correct
echo -e "\n$line_separator"

if [[ ! "$assumptions_correct" =~ ^[Nn]$ ]]; then
    echo -e "\nContinuing with the script..."
else
    echo -e "\nThe script will likely still work, but for best results, consider reinstalling. Exiting..."
    exit
fi
