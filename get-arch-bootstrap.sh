#!/bin/bash
ARCH_VERSION=2020.04.01
echo 'get the bootstrap and chroot into there (/tmp/root.x86_64/)'
cd /tmp
wget http://nlrtm1-edge1.cdn.i3d.net/o1/k9999/pub/archlinux/iso/$ARCH_VERSION/archlinux-bootstrap-$ARCH_VERSION-x86_64.tar.gz.sig
wget http://nlrtm1-edge1.cdn.i3d.net/o1/k9999/pub/archlinux/iso/$ARCH_VERSION/archlinux-bootstrap-$ARCH_VERSION-x86_64.tar.gz
gpg --keyserver-options auto-key-retrieve --verify archlinux-bootstrap-$ARCH_VERSION-x86_64.tar.gz.sig
echo 'extract the archive'
sudo tar xzf archlinux-bootstrap-$ARCH_VERSION-x86_64.tar.gz 
echo 'arch-chroot into /mnt/arch-root'
sudo grub2-editenv - set menu_show_once=1
sudo ./root.x86_64/bin/arch-chroot /mnt/archroot/
