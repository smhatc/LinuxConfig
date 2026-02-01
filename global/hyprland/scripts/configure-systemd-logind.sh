# Prevent systemd-logind from handling laptop lid switch and power button events
# Hyprland config maps both events to suspend (or any other potential action) instead
logind_dir="/etc/systemd/logind.conf.d"
logind_config="$logind_dir/lid-powerbtn.conf"

echo "${process_icon} Preventing systemd-logind from handling laptop lid switch and power button events..."
if [[ -d "$logind_dir" ]]; then
    sudo tee "$logind_config" >/dev/null <<EOF
[Login]
HandleLidSwitch=ignore
HandlePowerKey=ignore
EOF
    echo "${success_icon} Finished preventing systemd-logind from handling laptop lid switch and power button events."
else
    echo "${error_icon} \"${logind_dir}\" directory does not exist. Failed to apply systemd-logind tweaks."
fi
