# Directly install fonts from outside distro repositories, useful for rare or non-free fonts

# JetBrainsMono Nerd Font
curl -sSLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
sudo tar -xJf JetBrainsMono.tar.xz -C /usr/share/fonts
sudo fc-cache -fv
rm JetBrainsMono.tar.xz

# Microsoft fonts (local install, ignored if directory not provided)
if [[ -d ./global/general/fonts/microsoft ]]; then
    sudo cp -r ./global/general/fonts/microsoft /usr/share/fonts
    sudo fc-cache -fv
fi
