# Displaying assumptions the script expects from the environment it is being run in
cat ./opensuse-tumbleweed/hyprland/other/assumptions.txt

echo -e "$line_separator\n"
read -rp "Does your OS installation match the above description? [Y/n] " assumptions_correct
echo -e "\n$line_separator"

if [[ ! "$assumptions_correct" =~ ^[Nn]$ ]]; then
    echo -e "\nContinuing with the script..."
else
    echo -e "\nThe script will likely still work, but for best results, consider reinstalling. Exiting..."
    exit
fi
