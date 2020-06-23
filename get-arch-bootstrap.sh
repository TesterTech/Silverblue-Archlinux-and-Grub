#!/bin/bash
ARCH_VERSION=2020.06.01
LVM_PARTITION=rhel-arch--root
MOUNT_POINT=/mnt/archroot

echo "Mount ${LVM_PARTITION} to mount point ${MOUNT_POINT}"
if [[ ! -d /mnt/archroot ]];
    echo "The dir ${MOUNT_POINT} does not exist, create it. "
    then sudo mkdir /mnt/archroot
fi
sudo mount /dev/mapper/$LVM_PARTITION $MOUNT_POINT

echo 'get the bootstrap and chroot into there (/tmp/root.x86_64/)'
cd /tmp

if [[ ! -f archlinux-bootstrap-$ARCH_VERSION-x86_64.tar.gz.sig ]]; then 
    echo "download sig file"
    wget http://nlrtm1-edge1.cdn.i3d.net/o1/k9999/pub/archlinux/iso/$ARCH_VERSION/archlinux-bootstrap-$ARCH_VERSION-x86_64.tar.gz.sig
fi
if [[ ! -f archlinux-bootstrap-$ARCH_VERSION-x86_64.tar.gz ]]; then
    echo "download bootstrap tar.gz"
    wget http://nlrtm1-edge1.cdn.i3d.net/o1/k9999/pub/archlinux/iso/$ARCH_VERSION/archlinux-bootstrap-$ARCH_VERSION-x86_64.tar.gz
fi
gpg --keyserver-options auto-key-retrieve --verify archlinux-bootstrap-$ARCH_VERSION-x86_64.tar.gz.sig
echo "extract the archive"
sudo tar xzf archlinux-bootstrap-$ARCH_VERSION-x86_64.tar.gz 
echo "arch-chroot into ${MOUNT_POINT}"
sudo grub2-editenv - set menu_show_once=1
sudo ./root.x86_64/bin/arch-chroot /mnt/archroot/

