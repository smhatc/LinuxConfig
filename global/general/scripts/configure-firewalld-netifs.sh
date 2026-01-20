# Configuring system firewall (firewalld) and network interface connections (changing DNS and disabling IPv6)
echo -e "${process_icon} Configuring system firewall (firewalld) and network interface connections (changing DNS and disabling IPv6)...\n"

## Setting the default zone and blocking all inbound traffic (meant for any unknown and untrusted connections)
default_zone="public"
echo "${process_icon} Setting the default zone and blocking all inbound traffic..."
sudo firewall-cmd --set-default-zone="$default_zone"
### Removing all default allowed inbound services on default zone
for s in $(sudo firewall-cmd --zone="$default_zone" --list-services); do
    sudo firewall-cmd --zone="$default_zone" --remove-service="$s" --permanent
done
### Removing all default allowed inbound ports on default zone
for p in $(sudo firewall-cmd --zone="$default_zone" --list-ports); do
    sudo firewall-cmd --zone="$default_zone" --remove-port="$p" --permanent
done
echo "${success_icon} Finished setting the default zone and blocking all inbound traffic."

echo "$line_separator_small"

## Allowing inbound mDNS and LocalSend traffic on another, trusted zone, and blocking all other traffic
trusted_zone="home"
echo "${process_icon} Allowing inbound mDNS and LocalSend traffic on another, trusted zone, and blocking all other traffic..."
### Removing all default allowed inbound services on trusted zone
for s in $(sudo firewall-cmd --zone="$trusted_zone" --list-services); do
    sudo firewall-cmd --zone="$trusted_zone" --remove-service="$s" --permanent
done
### Removing all default allowed inbound ports on trusted zone
for p in $(sudo firewall-cmd --zone="$trusted_zone" --list-ports); do
    sudo firewall-cmd --zone="$trusted_zone" --remove-port="$p" --permanent
done
### Allowing inbound mDNS and LocalSend traffic on trusted zone
sudo firewall-cmd --zone="$trusted_zone" --add-service=mdns --permanent
sudo firewall-cmd --zone="$trusted_zone" --add-port=53317/tcp --permanent
sudo firewall-cmd --zone="$trusted_zone" --add-port=53317/udp --permanent
echo "${success_icon} Finished allowing inbound mDNS and LocalSend traffic on another, trusted zone, and blocking all other traffic."

echo "$line_separator_small"

## Applying the trusted zone to trusted network connections, disabling automatic DNS (in favor of privacy option), and disabling IPv6
trusted_connections_list="./global/general/configurations/trusted-connections-list.txt"
echo "${process_icon} Applying the trusted zone to trusted network connections, disabling automatic DNS (in favor of privacy option), and disabling IPv6..."
if [[ ! -r "$trusted_connections_list" ]]; then
    echo "${error_icon} No trusted connections list found. Skipping network zone assignment and DNS/IPv6 tweaks..."
else
    while IFS= read -r name || [[ -n "$name" ]]; do
        name="${name%%#*}"
        name="${name#"${name%%[![:space:]]*}"}"
        name="${name%"${name##*[![:space:]]}"}"
        [[ -z "$name" ]] && continue

        if sudo nmcli connection show "$name" >/dev/null 2>&1; then
            if sudo nmcli connection modify "$name" connection.zone "$trusted_zone" >/dev/null 2>&1; then
                echo "Applied zone \"${trusted_zone}\" to \"${name}\"."
                if sudo nmcli connection modify "$name" ipv4.dns "9.9.9.9 149.112.112.112" ipv4.ignore-auto-dns yes ipv6.method disabled >/dev/null 2>&1; then
                    if sudo nmcli connection up "$name" >/dev/null 2>&1; then
                        echo "Disabled automatic DNS and IPv6 for \"${name}\"."
                    else
                        echo "${error_icon} Failed to reactivate connection \"${name}\" after DNS and IPv6 change."
                    fi
                else
                    echo "${error_icon} Failed to disable automatic DNS and IPv6 for \"${name}\"."
                fi
            else
                echo "${error_icon} Failed to apply zone for \"${name}\"."
            fi
        else
            echo "${error_icon} NetworkManager profile for \"${name}\" not present. Skipping..."
        fi
    done <"$trusted_connections_list"
fi
echo "${success_icon} Finished applying the trusted zone to trusted network connections, disabling automatic DNS (in favor of privacy option), and disabling IPv6."

echo "$line_separator_small"

## Reloading the firewall to apply the changes immediately and printing the status
echo "${process_icon} Reloading the firewall to apply the changes immediately and printing the status..."
sudo firewall-cmd --reload
sudo firewall-cmd --zone="$default_zone" --list-all
sudo firewall-cmd --zone="$trusted_zone" --list-all
echo "${success_icon} Finished reloading the firewall to apply the changes immediately and printing the status."

echo -e "\n${success_icon} Finished configuring system firewall (firewalld) and network interface connections (changing DNS and disabling IPv6)."
