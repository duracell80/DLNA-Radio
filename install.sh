#!/bin/bash
# List Internet Radio Streams to DLNA Directory with Rygel

sudo apt update
sudo apt-get install -y python3-pip
sudo apt-get install -y gupnp-tools gstreamer1.0-tools rygel rygel-gst-launch rygel-playbin rygel-tracker

touch ~/.config/rygel.conf
touch ~/DLNA-Radio/got_youtube.txt
chmod a+x ~/DLNA-Radio/got_youtube.txt
chmod a+x start.sh


python3 main.py
