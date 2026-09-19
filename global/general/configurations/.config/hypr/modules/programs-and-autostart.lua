----------------
--- PROGRAMS ---
----------------

-- Linking commonly used programs, scripts, and options to variables

-- Essential services and system UI elements
idleDaemon = "hypridle"
udisks2Front = "udiskie"
polkitAuthAgent = "/usr/libexec/polkit-gnome-authentication-agent-1 || /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
wallpaperDaemon = "awww-daemon"
statusBar = "waybar"
notificationDaemon = "swaync"

-- Native apps
audioCtrl = "pavucontrol"
screenshotApp = "hyprshot"
screenshotAppRegionOpts = "-s -z -m region"
screenshotAppWindowOpts = "-s -z -m window"
screenshotAppMonitorOpts = "-s -z -m output"
screenshotAppSaveOpts = "-o $HOME/Pictures -f Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
virtManager = "virt-manager"
terminal = "kitty"
secondaryTerminal = "foot"
fileManager = "nautilus"
vscode = "code"

-- Flatpak apps
bleachbit = "flatpak run org.bleachbit.BleachBit"
emojiPicker = "flatpak run org.gnome.Characters"
notepad = "flatpak run org.gnome.TextEditor"
localSend = "flatpak run org.localsend.localsend_app"
keePassXC = "flatpak run org.keepassxc.KeePassXC"
yubicoAuthenticator = "flatpak run com.yubico.yubioath"
brave = "flatpak run com.brave.Browser"
bravePrivate = "flatpak run com.brave.Browser --incognito"
firefox = "flatpak run org.mozilla.firefox"
firefoxPrivate = "flatpak run org.mozilla.firefox --private-window"

-- Rofi scripts
wallpaperSwitcher = "~/.config/rofi/scripts/wallpaper-switcher.sh"
themeSwitcher = "~/.config/rofi/scripts/theme-switcher.sh"
appLauncher = "~/.config/rofi/scripts/app-launcher.sh"
powerMenu = "~/.config/rofi/scripts/power-menu.sh"

-- Waybar scripts
notificationMenu = "~/.config/waybar/scripts/notification-menu.sh"
notificationMenuShowOpts = "show"
notificationMenuDndOpts = "dnd"
volumeCtrl = "~/.config/waybar/scripts/volume.sh"
volumeCtrlMuteOutputOpts = "mute-output"
volumeCtrlLowerOutputOpts = "lower-output"
volumeCtrlRaiseOutputOpts = "raise-output"
volumeCtrlMuteInputOpts = "mute-input"
volumeCtrlLowerInputOpts = "lower-input"
volumeCtrlRaiseInputOpts = "raise-input"
nightLight = "~/.config/waybar/scripts/night-light.sh"
brightnessCtrl = "~/.config/waybar/scripts/brightness.sh"
brightnessCtrlRaiseOpts = "up"
brightnessCtrlLowerOpts = "down"

-- Shell scripts
backupScript = secondaryTerminal .. " -H bash -i -c bkup"
updateScript = secondaryTerminal .. " -H bash -i -c up"

-----------------
--- AUTOSTART ---
-----------------

-- Auto-starting specific programs on Hyprland startup

hl.on("hyprland.start", function()
    -- Essential services and system UI elements
    hl.exec_cmd(idleDaemon)
    hl.exec_cmd(udisks2Front)
    hl.exec_cmd(polkitAuthAgent)
    hl.exec_cmd(wallpaperDaemon)
    hl.exec_cmd(statusBar)
    hl.exec_cmd(notificationDaemon)
end)
