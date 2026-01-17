# Enabling ssh-agent systemd user unit (no ssh-agent handler by default on minimal Hyprland setup)
echo "${process_icon} Enabling Hyprland-specific services (ssh-agent)..."
systemctl --user daemon-reload && systemctl --user enable --now ssh-agent.service
echo "${success_icon} Finished enabling Hyprland-specific services (ssh-agent)."
