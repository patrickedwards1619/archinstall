# get user input
echo -e "\nEnter username to be created:\n"
read user


echo -e "\nEnter new password for $user:\n"
read uspw


echo -e "\nEnter new password for root:\n"
read rtpw


echo -e "\nEnter new hostname (device name):\n"
read host


echo -e "\nEnter desired timezone in format of Country/Region (the list of all timezones can be found by first switching to different virtual console using Alt+arrow shorcut and issuing command \"ls /usr/share/zoneinfo/*/* | less\"):\n"
read tmzn
#maybe excluse switching to a different console


echo -e "\nEnter the name of the hard drive you would like to use in format of /dev/<drive_name> (Drives can be listed by first switching to different virtual console using Alt+arrow shorcut and issuing command \"fdisk -l/*/* | less\"):\n"
read drve


echo -e "\nEnter the percentage of the drive you want to reserve for efi partition (don't include %):\n"
read drsz


# save these inputs in a file from which the respective fields will be sourced later
echo -e "$user $uspw $rtpw $host $tmzn $drve $drsz" > ./confidentials


echo -e "\nDone.\n\n"

#sleep 10





# verify that the system is booted in UEFI mode with…
ls /sys/firmware/efi/efivars

#sleep 10

# verify that the internet is working
ping -c 5 archlinux.org

#sleep 10


# wipe drive
wipefs --all "$drve"

# format Drive
parted -s -a optimal "$drve" mklabel gpt
parted -s -a optimal "$drve" mkpart "boot" 0% "$drsz"%
parted -s -a optimal "$drve" set 1 esp on
parted -s -a optimal "$drve" mkpart "root" "$drsz"% 100%
yes | mkfs.fat -F32 "$drve"1
yes | mkfs.ext4 "$drve"2

#sleep 10


# mount partitions           this may need to be changed to the way it is in doc
mount "$drve"2 /mnt
mkdir /mnt/boot
mount "$drve"1 /mnt/boot

#sleep 10

# update the system clock
timedatectl set-ntp true

#sleep 10


# configure pacman  MAYBE MOVE THIS SOMEWHERE ELSE
#sed -i 's #Color Color ; s #\[multilib\] \[multilib\] ; /\[multilib\]/{n;s #Include Include }' /etc/pacman.conf
#sleep 10
#echo -e "ILoveCandy" > /etc/pacman.conf

#sleep 10

# update pacman repositories
pacman -Sy

#sleep 10

#might need to install reflector
# update the mirror list
reflector -c US --latest 20 --sort rate --download-timeout 120 --connection-timeout 120 --save /etc/pacman.d/mirrorlist


#sleep 60


# install packages from the "pkgs" file
pacstrap /mnt $(cat pkgs.sh | sed 's #.*$  g' | tr '\n' ' ')

#sleep 10
#change out of the archinstall directory (might want to delete this line)
#cd

# generate an fstab file
genfstab -U /mnt >> /mnt/etc/fstab


# prepeare to change root into the new system and run config script     EVERYTHING IS PROVEN STABLE UP TO NOW (need to test)

# copy the confidentials file to destination system's root partition so that config script can access the file from inside of chroot
cp ./confidentials /mnt/root/

# copy the config script to destination system's root partition
cp ./config.sh /mnt/root/

# change file permission of config script to make it executable
chmod a+x /mnt/root/config.sh


# change root into the new system and run config script
arch-chroot /mnt #might need to remove /root/config here to get config script to run


# remove files that are now unnecessary
rm /mnt/root/{confidentials,config.sh}


# unmount all partitions
umount -R /mnt

# reboot the system
echo -e "\nInstallation Complete.\n\nSystem will reboot in 10 seconds..."

sleep 10

reboot
