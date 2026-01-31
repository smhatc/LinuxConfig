# Install any desired fonts which are rare to find in most distributions' main repositories
# Other fonts (Adwaita, Cantarell, Noto, Noto Emoji, and other general basic fonts) will be installed regularly via the specific package manager

# JetBrainsMono Nerd Font
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
sudo tar -xJf JetBrainsMono.tar.xz -C /usr/share/fonts
sudo fc-cache -fv
rm JetBrainsMono.tar.xz

# Microsoft fonts (local install, ignored if directory not provided)
if [[ -d ./global/general/fonts/microsoft ]]; then
    sudo cp -r ./global/general/fonts/microsoft /usr/share/fonts
    sudo fc-cache -fv
fi
