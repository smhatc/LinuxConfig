# Uninstall unneeded native apps (external list)
xargs sudo zypper rm -u -y <./opensuse-tumbleweed/general/applications/zypper-uninstall-app-list.txt

# Prevent the uninstalled apps from being reinstalled due to Zypper recommendations system
xargs sudo zypper al <./opensuse-tumbleweed/general/applications/zypper-uninstall-app-list.txt
