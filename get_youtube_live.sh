#!/bin/bash
# Use youtube-dl to get streamable audio URL for insertion into rygel.conf

youtube-dl --format best --get-url $1 > /home/pi/DLNA-Radio/got_youtube.txt
