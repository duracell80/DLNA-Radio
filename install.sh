#!/bin/bash
# List Internet Radio Streams to DLNA Directory with Rygel

sudo apt update
sudo apt install gstreamer1.0-tools
sudo apt install rygel
sudo apt install rygel-gst-launch

touch ~/.config/rygel.conf
chmod a+x start.sh

python3 main.py
