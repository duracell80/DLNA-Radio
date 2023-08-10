# DLNA-Radio
Most Internet Radio devices use a third party station database to populate stations in the radio. Sometimes these databases can be outdated or simply vanish off the Internet leaving you in a bit of a bind when trying to add or update your stations. If your device has DLNA / UPnP there is a quick hack using a server called Rygel that can give you a bridge to your device from a Laptop or Raspberry Pi.

Using Rygel to stream radio URL's over DLNA / UPnP. This requires the use of the gStreamer libraries, be sure to install gStreamer as needed for your distro first. There is a basic apt get for GS in the install file.

## Youtube and Youtube Live over DLNA
Work in progress and switching over to yt-dlp. Originally using youtube-dl it is possible to somewhat stream Youtube audio. Device's vary and the true YT Live streams don't have an audio only stream like the non live ones do.

Use audio/mp4 as the mime for non live streams, use audio/live in the stations.json for youtube live streams

## Devices Tested
Servers:
- Linux Mint 21.2
- Raspberry Pi (RpiOS Lite .. working in terminal)

Raspberry Pi may give this warning if not using desktop but will still function fine for sharing radio.

Rygel-Tracker-WARNING **: 03:30:15.720: Failed to start Tracker service: Cannot autolaunch D-Bus without X11 $DISPLAY. Plugin disabled.

Clients:
- LG Smart TV (complains not audio, maybe buffering?)
- VLC - Working
- Ocean Digital WR26 - Working
- Roku Media Player - Working
- Bubble UPnP Android - Working

## Setup

```
$ mkdir -p ~/git
$ cd ~/git
$ git clone https://github.com/duracell80/DLNA-Radio.git
$ cd ~/git/DLNA-Radio
$ chmod u+x install.sh
$ ./install.sh
```

## Adding Your Stations
Edit the stations.json file in the ~/python-apps/dlnaradio directory to add the Radio URL's you'd like to broadcast to your devices

```
{
    "dlna-conf": [
        { "library-name": "My Radio", "library-enabled": "true"}
    ],    
    "dlna-stations": [
        { "url": "https://0n-60s.radionetz.de/0n-60s.mp3", "name": "0n Radio - 60s", "mime" : "audio/mpeg" },
        { "url": "https://0n-70s.radionetz.de/0n-70s.mp3", "name": "0n Radio - 70s", "mime" : "audio/mpeg" }
    ]
}
```

dlna-conf ... A library name and turning the library on or off can be done here
dlna-stations ... enter a URL a name and a mime type (MP3 = audio/mpeg) (AAC = audio/mp4)

## To Run the DLNA Server:

Edit the s_rygel_file variable in main.py to your home directory accordingly.

```
$ cd ~/python-apps/dlnaradio
$ ./run.sh
```
Wait for the Python Virtual Environment to start, then run.sh again

```
$ ./run.sh
```


## Testing in VLC:
Launch VLC and on the left of the interface choose "Universal Plug n Play", if the server is running you will see a "Folder" called My Radio on (your host name).

## Listening on your Radio Device:
Depending on your device you will find the DLNA / UPnP function maybe under something called Media or Media Center. Browse in there and you will see a directory called My Radio on (your host name). Choose a station to listen to. The server on your Linux or Raspberry Pi needs to be running to access the streams in the DLNA directory.

If rygel has stopped working launch it again with the command:
```
rygel
```

## Autorun DLNA server:
Coming soon, updated with autostart of virtual environment
