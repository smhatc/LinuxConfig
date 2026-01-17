# Add current user to any needed groups
echo "${process_icon} Adding the current user to any needed groups (libvirt, vboxusers, wireshark)..."
sudo usermod -aG libvirt,vboxusers,wireshark "$(whoami)"
echo "${success_icon} Finished adding the current user to any needed groups (libvirt, vboxusers, wireshark)."
