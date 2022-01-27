#!/bin/bash
# Use youtube-dl to get streamable audio URL for insertion into rygel.conf

youtube-dl --format '140[ext=m4a][protocol=https]' --get-url $1 > /home/pi/DLNA-Radio/got_youtube.txt
