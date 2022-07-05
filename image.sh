#!/usr/bin/env bash
set echo off

if [ "$EUID" -ne 0 ]; then
    echo "[1/1] image.sh must be ran as root."
    exit 1
fi

dd if=/dev/zero bs=1M count=0 seek=64 of=loom.img

parted -s loom.img mklabel gpt

parted -s loom.img mkpart ESP fat32 2048s 100%
parted -s loom.img set 1 esp on

limine-install loom.img

USED_LOOPBACK=$(losetup -Pf --show loom.img)

mkfs.fat -F 32 ${USED_LOOPBACK}p1

mkdir -p img_mount
mount ${USED_LOOPBACK}p1 img_mount

mkdir -p img_mount/EFI/BOOT
cp -v loom.elf limine.cfg /usr/local/share/limine/limine.sys img_mount
cp -v /usr/local/share/limine/BOOTX64.EFI img_mount/EFI/BOOT/

sync
umount img_mount
losetup -d ${USED_LOOPBACK}