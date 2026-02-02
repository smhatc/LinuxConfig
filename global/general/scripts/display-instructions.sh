# Displaying instructions about optional script configurations
cat ./global/general/other/instructions.txt

echo -e "$line_separator\n"
read -rp "Would you like to exit the script now to go create these directories/files? [Y/n] " exit_script
echo -e "\n$line_separator"

if [[ ! "$exit_script" =~ ^[Nn]$ ]]; then
    echo -e "\nGreat! Please go create the directories/files and run the script again. Exiting..."
    exit
fi
