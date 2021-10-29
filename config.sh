echo -e "\nChrooted into new environment\n"
sleep 2
echo -e "\nRunning config script\n"
sleep 2


# configure pacman
echo -e "\nConfiguring pacman\n"
sleep 2
sed -i 's #Color Color\nILoveCandy ; s #\[multilib\] \[multilib\] ; /\[multilib\]/{n;s #Include Include }' /etc/pacman.conf
pacman -Sy
echo -e "\nDone\n"
sleep 2


# install kde plasma
echo -e "\nInstalling KDE Plasma\n"
sleep 2
pacman -S --noconfirm xorg-server xf86-video-amdgpu xf86-video-intel xf86-video-vmware plasma-desktop sddm sddm-kcm
echo -e "\nDone\n"
sleep 2


# install personal packages
echo -e "\nInstalling personal packages\n"
sleep 2
pacman -S --noconfirm atom bitwarden bleachbit blender clamav clonezilla deluge-gtk digikam dolphin filelight firefox flatpak gimp guake gwenview handbrake hardinfo kate khelpcenter kinfocenter ksystemlog libreoffice-fresh nmap okular partitionmanager rkhunter shotcut spectacle steam ufw virtualbox virtualbox-guest-iso virtualbox-guest-utils virtualbox-host-modules-arch vlc
echo -e "\nDone\n"
sleep 2


# install necessary packages
echo -e "\nInstalling necessary packages\n"
sleep 2
pacman -S --noconfirm mlocate man-db man-pages bat breeze-grub breeze-gtk cpupower kde-gtk-config kscreen nano p7zip pacman-contrib pulseaudio alsa-utils plasma-pa pulseaudio-alsa pulseaudio-bluetooth pulseaudio-equalizer pulseaudio-lirc pulseaudio-zeroconf reflector sudo unzip vim
echo -e "\nDone\n"
sleep 2


# install plasma packages
echo -e "\nInstalling plasma packages\n"
sleep 2
pacman -S --noconfirm plasma-disks plasma-firewall plasma-nm plasma-systemmonitor plasma-thunderbolt powerdevil print-manager










# import user inputs from /root/confidentials
read -r user uspw rtpw host tmzn < /root/confidentials


# set the time and language
echo -e "\nSetting time and language\n"
sleep 2
ln -sf /usr/share/zoneinfo/$tmzn /etc/localtime
hwclock --systohc
sed -i 's #en_US.UTF-8 en_US.UTF-8 ' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo -e "\nDone\n"
sleep 2


# set the hostname
echo -e "\nSetting hostname\n"
sleep 2
echo -e "$host" > /etc/hostname
echo -e "\nDone\n"
sleep 2


# configure the network
echo -e "\nConfiguring Network\n"
sleep 2
echo -e "127.0.0.1   localhost\n::1         localhost\n127.0.1.1   $host" >> /etc/hosts
echo -e "\nDone\n"
sleep 2


# set root password
echo -e "\nSetting root password\n"
sleep 2
echo -e "$rtpw\n$rtpw" | passwd root
echo -e "\nDone\n"
sleep 2


# add a new user with password
echo -e "\nAdding User\n"
sleep 2
useradd -m -g users -G wheel -s /bin/bash $user
echo -e "$uspw\n$uspw" | passwd $user
echo -e "%wheel ALL=(ALL) ALL\n" > /etc/sudoers.tmp
echo -e "\nDone\n"
sleep 2


# enable microcode updates
echo -e "\nEnabling microcode updates\n"
sleep 2
pacman -S amd-ucode --noconfirm
echo -e "\nDone\n"
sleep 2


# install a bootloader
echo -e "\nInstalling bootloader\n"
sleep 2
pacman -S grub efibootmgr --noconfirm
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
echo -e "\nDone\n"
sleep 2


# configure reflector
echo -e "\nConfiguring reflector\n"
sleep 2
echo -e "--country United States\n" > /etc/xdg/reflector/reflector.conf
echo -e "\nDone\n"
sleep 2


# speed up building aur packages
echo -e "\nReducing AUR package build times\n"
sleep 2

echo -e "\nDone\n"
sleep 2


# make all apps dark theme
echo -e "\nMaking all apps dark theme\n"
sleep 2

echo -e "\nDone\n"
sleep 2


# change cpu to ondemand mode
echo -e "\nChanging cpu to ondemand mode\n"
sleep 2

echo -e "\nDone\n"
sleep 2


# disable power saving mode for sound card
echo -e "\nDisabling power saving mode for sound card\n"
sleep 2

echo -e "\nDone\n"
sleep 2




# enable systemd services
echo -e "\nEnabling systemd services\n"
sleep 2
systemctl enable NetworkManager sddm reflector.service fstrim.timer
echo -e "\nDone\n"
sleep 2


# exit the chroot environment (does this automatically when script ends)
echo -e "\nExiting the chroot environment in 10 seconds\n"
sleep 10




