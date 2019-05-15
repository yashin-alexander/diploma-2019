#!/bin/bash -e

on_chroot << EOF
apt-get purge `dpkg --get-selections | grep gnome | cut -f 1`
apt-get purge `dpkg --get-selections | grep deinstall | cut -f 1`
apt autoremove
EOF
