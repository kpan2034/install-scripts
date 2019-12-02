#!/bin/bash

######################################################################
# @author      : kpan (kpan@$HOSTNAME)
# @file        : wifi-driver-script
# @created     : Monday Dec 02, 2019 20:40:55 IST
#
# @description : Fix wifi issues for RTL8723be on Ubuntu
######################################################################

# Get driver (thanks lwfinger!)
mkdir tmp
cd tmp
sudo apt install build-essential
git clone https://github.com/lwfinger/rtlwifi_new.git

# Install driver
cd rtlwifi_new
make
sudo make install

# Change antenna
sudo modprobe -r rtl8723be
sudo modprobe rtl8723be
sudo echo "options rtl8723be ant_sel=2" >> /etc/modprobe.d/50-rtl8723be.conf

