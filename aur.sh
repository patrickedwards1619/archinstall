# refresh paru
echo -e "\nRefreshing paru\n"
sleep 2
paru -Sy --noconfirm
echo -e "\nDone\n"
sleep2


# install AUR packages
echo -e "\nInstalling AUR packages\n"
sleep 2
paru -S --noconfirm chrome-remote-desktop discord_arch_electron etcher-bin google-chrome mailspring makemkv multimc-bin nordvpn-bin phoronix-test-suite spotify timeshift virtualbox-ext-oracle
echo -e "\nDone\n"
sleep 2


echo -e "\nConfiguring AUR packages\n"
sleep 2

echo -e "\nDone\n"
sleep 2




# enable systemd services
echo -e "\nEnabling AUR systemd services\n"
sleep 2
systemctl enable --now nordvpnd
echo -e "\nDone\n"
sleep 2
