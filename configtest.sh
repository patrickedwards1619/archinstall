# configure pacman
sed -i 's #Color Color ; s #\[multilib\] \[multilib\] ; /\[multilib\]/{n;s #Include Include }' /etc/pacman.conf
echo -e "ILoveCandy" >> /etc/pacman.conf
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
echo -e "127.0.0.1  localhost\n::1         localhost\n127.0.1.1    $host" >> /etc/hosts

#sleep 10

# set root password
echo -e "$rtpw\n$rtpw" | passwd root

#sleep 10

# add a new user with password
useradd -m -G wheel -s /bin/bash $user
echo -e "$uspw\n$uspw" | passwd $user
