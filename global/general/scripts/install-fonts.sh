# Install any desired fonts which are rare to find in most distributions' main repositories
# Other fonts (Adwaita, Cantarell, Noto, Noto Emoji, and other general basic fonts) will be installed regularly via the specific package manager

# JetBrainsMono Nerd Font
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
sudo tar -xJf JetBrainsMono.tar.xz -C /usr/share/fonts
sudo fc-cache -fv
rm JetBrainsMono.tar.xz

# Microsoft fonts (local install, path from perspective of distributions' setup script)
if [[ -d ../global/fonts/microsoft ]]; then
    sudo cp -r ../global/fonts/microsoft /usr/share/fonts
    sudo fc-cache -fv
fi
