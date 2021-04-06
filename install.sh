#!/bin/bash
# List Internet Radio Streams to DLNA Directory with Rygel

sudo apt update
sudo apt-get install -y gupnp-tools gstreamer1.0-tools rygel rygel-gst-launch rygel-playbin rygel-tracker

touch ~/.config/rygel.conf
touch ./got_youtube.txt
chmod a+x start-linux.sh
chmod a+x got_youtube.txt

python3 main-linux.py
