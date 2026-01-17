# Install Yubico Authenticator
echo -e "\n${process_icon} Installing Yubico Authenticator..."
wget -P ~ https://developers.yubico.com/yubioath-flutter/Releases/yubico-authenticator-latest-linux.tar.gz
tar -xzf ~/yubico-authenticator-* -C ~
rm ~/yubico-authenticator-*.tar.gz
mv ~/yubico-authenticator-* ~/.yubico-authenticator
~/.yubico-authenticator/desktop_integration.sh --install
echo "${success_icon} Finished installing Yubico Authenticator."
