# configure pacman
sed -i 's #Color Color\nILoveCandy ; s #\[multilib\] \[multilib\] ; /\[multilib\]/{n;s #Include Include }' /etc/pacman.conf
pacman -Sy


# maybe install stuff from pkgs script here since we just now enabled the multilib repository
#sleep 10

# import user inputs from /root/confidentials
read -r user uspw rtpw host tmzn < /root/confidentials

#sleep 10

# set the time and language
ln -sf /usr/share/zoneinfo/$tmzn /etc/localtime
hwclock --systohc
sed -i 's #en_US.UTF-8 en_US.UTF-8 ' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

#sleep 10

# set the hostname
echo -e "$host" > /etc/hostname

#sleep 10

# configure the network          this may be a problem
echo -e "127.0.0.1   localhost\n::1         localhost\n127.0.1.1   $host" >> /etc/hosts

#sleep 10

# set root password
echo -e "$rtpw\n$rtpw" | passwd root

#sleep 10

# add a new user with password
Useradd -m -g users -G wheel -s /bin/bash $user
echo -e "$uspw\n$uspw" | passwd $user
echo -e "%wheel ALL=(ALL) ALL\n" > /etc/sudoers.d


# enable microcode updates
pacman -S amd-ucode --noconfirm


# install a bootloader           this may need to be changed to the way it is in doc
pacman -S grub efibootmgr --noconfirm
#sleep 10
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
#sleep 10
grub-mkconfig -o /boot/grub/grub.cfg



# enable systemd services
pacman -S networkmanager --noconfirm
systemctl enable NetworkManager sddm


# exit the chroot environment
echo -e "\nExiting the chroot environment in 10 seconds\n"
sleep 10

Exit



