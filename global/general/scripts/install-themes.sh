# Directly install desired themes in case they are not available in distro repositories

# adw-gtk3 theme
adw_gtk3_url="$(curl -sS https://api.github.com/repos/lassekongo83/adw-gtk3/releases/latest |
    grep -o '"browser_download_url": "[^"]*\.tar\.xz"' |
    head -1 | cut -d'"' -f4)"
curl -sSLO "$adw_gtk3_url"

adw_gtk3_tar="$(basename "$adw_gtk3_url")"
sudo tar -xJf "$adw_gtk3_tar" -C /usr/share/themes
rm "$adw_gtk3_tar"
