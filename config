# configure pacman
sed -i 's #Color Color ; s #\[multilib\] \[multilib\] ; /\[multilib\]/{n;s #Include Include }' /etc/pacman.conf
echo "ILoveCandy" >> /etc/pacman.conf
pacman -Syyu --noconfirm



# import user inputs from /root/confidentials
read -r user uspw rtpw host tmzn < /root/confidentials



# set the time and language
ln -sf /usr/share/zoneinfo/"United States"/Chicago /etc/localtime
hwclock --systohc
sed -i 's #en_US.UTF-8 en_US.UTF-8 ' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf



# set the hostname
echo -e "$host" > /etc/hostname



# configure the network          this may be a problem
echo -e "127.0.0.1  localhost\n::1      localhost\n127.0.1.1    $host" >> /etc/hosts



# set root password
echo -e "$rtpw\n$rtpw" | passwd root



# add a new user with password
useradd -m -G wheel -s /bin/bash $user
echo -e "$uspw\n$uspw" | passwd $user
echo -e "root ALL=(ALL) NOPASSWD: ALL\n%wheel ALL=(ALL) NOPASSWD: ALL\n" > /etc/sudoers.d/00_nopasswd



# enable microcode updates
pacman -S amd-ucode



# install a bootloader           this may need to be changed to the way it is in doc
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg



# enable systemd services
systemctl enable NetworkManager sddm



# exit chroot environment
exit
