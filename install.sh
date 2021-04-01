#!/bin/bash
# List Internet Radio Streams to DLNA Directory with Rygel

sudo apt update
sudo apt-get install -y pavucontrol paprefs gupnp-tools gstreamer1.0-tools rygel rygel-gst-launch rygel-playbin rygel-tracker

touch ~/.config/rygel.conf
chmod a+x start.sh

python3 main.py
