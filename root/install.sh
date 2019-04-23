#!/bin/bash

DISK="/dev/$1"
if [ "$1" = "sda" ]; then
  # regular hard drive
  PARTITION="${DISK}1"
elif [ "$1" = "mmcblk0" ]; then
  # MMC memory
  PARTITION_BOOT="${DISK}p1"
  PARTITION="${DISK}p2"
else
  # unknown case, stop execution
  echo "Sorry, I can only support 'sda' or 'mmcblk0' disk types :)"
  exit 1
fi

echo DISK="$DISK", PARTITION="$PARTITION"

# TODO: steps done by hand:
# Setup a GPT partition table
# parted -s "$DISK" mklabel gpt
# Create a 273MB partition for UEFI
# TODO: parted -s -a optimal "$DISK" mkpart primary ext4 2048 273MB
# Set the rest for the OS:
# TODO: parted -s -a optimal "$DISK" mkpart primary ext4 0% 100%

# Format the partitions
# UEFI doesn't have a `boot` flag, it's done in a different way (see Dropbox notes 2018-11-30-installing-arch-linux.md)
# UEFI partition requires FAT32 filesystem
mkfs.fat -F32 "$PARTITION_BOOT"
mkfs.ext4 "$PARTITION"

# you can find your closest server from: https://www.archlinux.org/mirrorlist/all/
# echo 'Server = http://mirror.internode.on.net/pub/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
# pacman -Syy

# ensure to mount the UEFI partition as well, you will needed
# in chroot.sh when dealing with GRUB
mkdir -p /mnt/efi/EFI/arch
mount "$PARTITION_BOOT" /mnt/efi
cp -a /mnt/boot/vmlinuz-linux /efi/EFI/arch/
cp -a /mnt/boot/initramfs-linux.img /mnt/efi/EFI/arch/
cp -a /mnt/boot/initramfs-linux-fallback.img /mnt/efi/EFI/arch/
mount "$PARTITION" /mnt

# Install the base packages
pacstrap /mnt base base-devel grub efibootmgr openssh sudo networkmanager

# CONFIGURE THE SYSTEM
# Generate an fstab file
genfstab -U /mnt > /mnt/etc/fstab

# Change root into the system (remotely)
cp ./chroot.sh /mnt
cp ~/.ssh/authorized_keys /mnt
arch-chroot /mnt ./chroot.sh "$DISK"
rm /mnt/chroot.sh
rm /mnt/authorized_keys

umount -R /mnt
systemctl reboot