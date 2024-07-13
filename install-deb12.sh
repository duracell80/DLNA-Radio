#!/bin/bash
# List Internet Radio Streams to DLNA Directory with Rygel

DIR_PWD=$(pwd)
DIR_NME="dlnaradio"
DIR_ENV=$HOME/python-apps
DIR_APP=$DIR_ENV/$DIR_NME

WHOAMI=$(whoami)

sudo apt update
sudo apt install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev gstreamer1.0-* python3-pip python3.11-venv gupnp-tools rygel rygel-gst-launch rygel-playbin rygel-tracker rygel-preferences rygel-2.8-dev tumbler grilo-plugins-0.3

# Include pulseaudio-dlna source if needed ... Debian is moving to pipewire
#wget -nc https://github.com/masmu/pulseaudio-dlna/archive/refs/tags/0.5.2.zip
#unzip 0.5.2.zip



# VENV - Setup
mkdir -p $DIR_ENV && cd $DIR_ENV

# VENV - DLNARadio
python3 -m venv $DIR_NME
source $DIR_APP/bin/activate

# VENV - Install requirements
mkdir -p $DIR_APP/app
cd $DIR_APP
cp $DIR_PWD/*.sh $DIR_APP/app
cp $DIR_PWD/*.json $DIR_APP/app
cp $DIR_PWD/main.py $DIR_APP/app
cp $DIR_PWD/requirements.txt $DIR_APP
cp $DIR_PWD/dlna.start $DIR_APP
cp $DIR_PWD/dlna.stop $DIR_APP
cp $DIR_PWD/dlna.status $DIR_APP



mv -f $DIR_APP/app/run.sh $DIR_APP
rm -f $DIR_APP/app/install*


touch $HOME/.config/rygel.conf
touch $DIR_APP/app/got_youtube.txt
chmod a+r $DIR_APP/app/got_youtube.txt

cd $DIR_PWD

sudo cp $DIR_PWD/icons/120x120/rygel.png /usr/share/rygel/icons/120x120/
sudo cp $DIR_PWD/icons/120x120/rygel.jpg /usr/share/rygel/icons/120x120/

sudo cp $DIR_PWD/icons/48x48/rygel.png /usr/share/rygel/icons/48x48
sudo cp $DIR_PWD/icons/48x48/rygel.jpg /usr/share/rygel/icons/48x48

# Autostart
cp $DIR_PWD/dlna.service $DIR_PWD/dlna.service.tmp
sed -i "s|~/|$HOME/|g" $DIR_PWD/dlna.service.tmp
sed -i "s|whoisme|$WHOAMI|g" $DIR_PWD/dlna.service.tmp
sudo mv $DIR_PWD/dlna.service.tmp /lib/systemd/system/dlna.service
sudo systemctl daemon-reload
sudo systemctl enable dlna.service
sudo systemctl start dlna.service

sleep 8
