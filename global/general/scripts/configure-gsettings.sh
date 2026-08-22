# Configuring dconf database settings
echo -e "${process_icon} Configuring dconf database settings...\n"

## Enabling window control buttons for overall theme consistency between different app types (GTK, Qt, Electron)
echo "${process_icon} Enabling window control buttons for overall theme consistency between different app types (GTK, Qt, Electron)..."
gsettings set org.gnome.desktop.wm.preferences button-layout "appmenu:minimize,maximize,close"
echo "${success_icon} Finished enabling window control buttons for overall theme consistency between different app types (GTK, Qt, Electron)."

echo -e "\n${success_icon} Finished configuring dconf database settings."
