# DLNA-Radio
Most Internet Radio devices use a third party station database to populate stations in the radio. Sometimes these databases can be outdated or simply vanish off the Internet leaving you in a bit of a bind when trying to add or update your stations. If your device has DLNA / UPnP there is a quick hack using a server called Rygel that can give you a bridge to your device from a Laptop or Raspberry Pi.

Using Rygel to stream radio URL's over DLNA / UPnP. This requires the use of the gStreamer libraries, be sure to install gStreamer as needed for your distro first. There is a basic apt get for GS in the install file.

## Devices Tested
Servers:
- Linux Mint 20
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
$ cd ~/
$ git clone https://github.com/duracell80/DLNA-Radio.git
$ cd DLNA-Radio
$ chmod a+x install-pi.sh
$ ./install-pi.sh
```

## Adding Your Stations
Edit the stations.json file to add the Radio URL's you'd like to broadcast to your devices

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
$ cd ~/
$ cd DLNA-Radio
$ ./start-pi.sh
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
Use your normal way to start a service but rather than starting rygel on its own, choose to run the start script which will then pick up any new stations you add to your stations.json file. 
