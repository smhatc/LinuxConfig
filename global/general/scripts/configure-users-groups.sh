# Add current user to any needed groups
echo "${process_icon} Adding the current user to any needed groups (libvirt, wireshark, docker)..."
sudo usermod -aG libvirt,wireshark,docker "$USER"
echo "${success_icon} Finished adding the current user to any needed groups (libvirt, wireshark, docker)."
