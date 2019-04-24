#!/bin/bash

DISK="/dev/$1"
if [ "$1" = "sda" ]; then
  # regular hard drive
  ESP="${DISK}1"
  PARTITION="${DISK}2"
  SWAP="$SWAP"
elif [ "$1" = "mmcblk0" ]; then
  # MMC memory
  ESP="${DISK}p1"
  PARTITION="${DISK}p2"
else
  # unknown case, stop execution
  echo "Sorry, I can only support 'sda' or 'mmcblk0' disk types :)"
  exit 1
fi

echo DISK="$DISK", ESP="$ESP", PARTITION="$PARTITION"
# echo DISK="$DISK", ESP="$ESP", PARTITION="$PARTITION", SWAP="$SWAP"

# Setup a GPT partition table
echo "Setting up a GPT partition table"
parted -s "$DISK" mklabel gpt
# Create a 273MB ESP (EFI System Partition)
echo "Creating a FAT32 partition of 273MB for EFI"
parted -s -a optimal "$DISK" mkpart primary fat32 0% 273MB
# TODO: set UEFI doesn't have a `boot` flag, it's done in a different way (see Dropbox notes 2018-11-30-installing-arch-linux.md)
# parted -s "$DISK" set 1 esp on
# TODO: create a swap partition
# Create a partition for the rest of the OS with the remaining space
echo "Creating a EXT4 partition with the remaining space for the OS"
parted -s -a optimal "$DISK" mkpart primary ext4 273MB 100%

# Format the partitions
# ESP requires a FAT32 filesystem
mkfs.fat -F32 "$ESP"
mkfs.ext4 "$PARTITION"
# TODO: swap partition
# mkswap "$SWAP"

# you can find your closest server from: https://www.archlinux.org/mirrorlist/all/
# echo 'Server = http://mirror.internode.on.net/pub/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
# pacman -Syy

# ensure to mount the UEFI partition as well, you will needed
# in chroot.sh when dealing with GRUB
mkdir -p /mnt/efi/EFI/arch
mount "$ESP" /mnt/efi
# cp -a /mnt/boot/vmlinuz-linux /mnt/efi/EFI/arch/
# cp -a /mnt/boot/initramfs-linux.img /mnt/efi/EFI/arch/
# cp -a /mnt/boot/initramfs-linux-fallback.img /mnt/efi/EFI/arch/
# mount "$PARTITION" /mnt
# Mount SWAP partition
# swapon "$SWAP"

# Install the base packages
# pacstrap /mnt base base-devel grub efibootmgr openssh sudo networkmanager

# # CONFIGURE THE SYSTEM
# # Generate an fstab file
# genfstab -U /mnt > /mnt/etc/fstab

# # Change root into the system (remotely)
# cp ./chroot.sh /mnt
# cp ~/.ssh/authorized_keys /mnt
# arch-chroot /mnt ./chroot.sh "$DISK"
# rm /mnt/chroot.sh
# rm /mnt/authorized_keys

# umount -R /mnt
# systemctl reboot