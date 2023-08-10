#!/bin/bash
# List Internet Radio Streams to DLNA Directory with Rygel

DIR_PWD=$(pwd)
DIR_NME="dlnaradio"
DIR_ENV=$HOME/python-apps
DIR_APP=$DIR_ENV/$DIR_NME

sudo apt update
sudo apt-get install python3-pip python3.10-venv gupnp-tools gstreamer1.0-tools rygel rygel-gst-launch rygel-playbin rygel-tracker rygel-preferences tumbler grilo-plugins-0.3

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


mv -f $DIR_APP/app/run.sh $DIR_APP
rm -f $DIR_APP/app/install*


touch $HOME/.config/rygel.conf
touch $DIR_APP/app/got_youtube.txt
chmod a+r $DIR_APP/app/got_youtube.txt

cd $PWD
