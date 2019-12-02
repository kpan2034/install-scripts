#!/bin/bash

# So you wanna set up your system after a format?
# But forgot all the stuff you've installed?
# Thank God I've noted most of the stuff here for you
# -Past You


# Let's start off by grabbing i3-gaps, argubly the most important. I hope you still have your config.

# For Ubuntu 16.04

# No package available for Ubuntu, so install everything manually

# Dependencies
# adding repository to install libxcb-xrm-dev
sudo add-apt-repository ppa:aguignard/ppa
sudo apt-get update

sudo apt install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf xutils-dev libtool libxcb-shape0-dev

# Jump through hoops to install xcb--util-xrm which isn't found on 16.04
cd /tmp
git clone https://github.com/Airblader/xcb-util-xrm
cd xcb-util-xrm
git config --global url.https://anongit.freedesktop.org/git.insteadOf git://anongit.freedesktop.org
git submodule update --init
./autogen.sh --prefix=/usr
make
sudo make install

# get repository
cd ~/
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps

# compile & install
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/

# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install

# Install termite on ubuntu using helper script (Shoutout to Corwind)
wget https://raw.githubusercontent.com/Corwind/termite-install/master/termite-install.sh
. termite-install.sh

# Install zsh in case it isn't installed
sudo apt install zsh curl
# Install oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Install powerline for Vim and Zsh
# Dependencies
sudo apt install python3-pip git socat xrandr
pip3 install psutil pygit2 bzr pyuv i3ipc
pip3 install powerline-status

# run powerline on your new zsh installation
echo . `pip3 show powerline-status | grep "Location: " | awk '{printf "%s\n", $2}'`/powerline/bindings/zsh/powerline.zsh >> ~/..zshrc
sudo apt install fonts-powerline

# If you get rectangular boxes follow instructions here:
# https://unix.stackexchange.com/questions/352426/how-to-get-the-arrow-style-bash-prompt-after-installing-powerline

# Install rofi or dmenu

# sudo apt install dmenu
sudo apt install rofi

# Compton for transparent terminals
sudo apt install compton compton-conf
apt install build-essential git cmake cmake-data pkg-config libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev \
libnl-genl-3-dev libiw-dev libcurl4-openssl-dev libmpdclient-dev libpulse-dev libjsoncpp-dev libasound2-dev libasound2-dev libxcb-cursor-dev libxcb-xrm-dev 

# Polybar time
wget https://github.com/jaagr/polybar/releases/download/3.3.0/polybar-3.3.0.tar
tar -xvf polybar-3.3.0.tar
cd polybar/
mkdir build
cd build
cmake ..
make -j$(nproc)  
sudo make install

# Fix my damn wifi driver

chmod u+x wifi-driver-script.sh
./wifi-driver-script.sh

#cd ~/software
#sudo apt install build-essential
#git clone https://github.com/lwfinger/rtlwifi_new.git
#cd rtlwifi_new
#make
#sudo make install

#sudo modprobe -r rtl8723be
#sudo modprobe rtl8723be
#sudo echo "options rtl8723be ant_sel=2" >> /etc/modprobe.d/50-rtl8723be.conf

# Polybar module downloads

#pip3 install --upgrade oauth2client google-api-python-client --user
#sudo apt install jq udisks2

# Download and install wal if not present, courtesy Dylanaraps/wal

if [ ! -f "wal" ]; then
    echo "Getting wal script..."
    wget https://raw.githubusercontent.com/dylanaraps/wal/master/wal
fi
chmod u+x wal

# Get betterlockscreen install script, courtest UtkarshVerma/installer-scripts
if [ ! -f "betterlockscreen.sh" ]; then
    echo "Getting betterlockscreen install script..."
   wget https://raw.githubusercontent.com/UtkarshVerma/installer-scripts/master/betterlockscreen.sh
fi

echo "Installing betterlockscreen..."
chmod u+x betterlockscreen.sh
./betterlockscreen.sh
