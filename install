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


# the next 4 lines may be problems
echo -e "\nEnter the name of the hard drive you would like to use in format of /dev/<drive_name> (Drives can be listed by first switching to different virtual console using Alt+arrow shorcut and issuing command \"fdisk -l/*/* | less\"):\n"

read drve

echo -e "\nEnter the percentage of the drive you want to reserve for efi partition:\n"

read drsz


# save these inputs in a file from which the respective fields will be sourced later
echo -e "$user $uspw $rtpw $host $tmzn $drve $drsz" > ./confidentials


echo -e "\nDone.\n\n"

sleep 10

# verify that the system is booted in UEFI mode with…
ls /sys/firmware/efi/efivars

sleep 10

# verify that the internet is working
ping -c 10 archlinux.org



# update the system clock
timedatectl set-ntp true

sleep 10

# format Drive
parted -s -a optimal "$drv" mklabel gpt
parted -s -a optimal "$drv" mkpart "boot" fat32 0% "$drsz"%
parted -s -a optimal "$drv" set 1 esp on
parted -s -a optimal "$drv" mkpart "root" ext4 "$drsz"% 100%
mkfs.fat -F32 /dev/"$drv"1
mkfs.ext4 /dev/"$drv"2

sleep 10

# mount partitions           this may need to be changed to the way it is in doc
mount "$drv"2 /mnt
mkdir /mnt/boot
mount "$drv"1 /mnt/boot

sleep 10

# update pacman repositories
pacman -Sy

sleep 10

# update the mirror list
reflector -c “United States” -f 10 -l 8 -n 10 --download-timeout 60 --save /etc/pacman.d/mirrorlist

sleep 10

# install packages

# install essential packages
pacstrap /mnt base linux linux-firmware
    #If installing in a container, you can omit linux and linux-firmware
    #If installing in a virtual machine, you can omit linux-firmware
sleep 10
# install all other packages from the "pkgs" file
pacstrap /mnt $(cat pkgs | sed 's #.*$  g' | tr '\n' ' ')

sleep 10

# generate an fstab file
genfstab -U /mnt >> /mnt/etc/fstab


sleep 10
# prepeare to change root into the new system and run config script

# copy the confidentials file to destination system's root partition so that config script can access the file from inside of chroot
cp ./confidentials /mnt/root/

# copy the config script to destination system's root partition
cp ./config /mnt/root/

# change file permission of config script to make it executable
chmod a+x /mnt/root/config



# change root into the new system and run config script
arch-chroot /mnt /root/config



# remove user input file
rm /mnt/root/{confidentials,config}



# unmount all partitions
umount -R /mnt



# reboot
reboot










# exit the chroot environment



# unmount all partitions
umount -R /mnt



# reboot
reboot

