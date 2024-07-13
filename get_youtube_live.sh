#!/bin/bash
# Use youtube-dl to get streamable audio URL for insertion into rygel.conf

youtube-dl --format best --get-url $1 > ~/python-apps/dlnaradio/app/got_youtube.txt
