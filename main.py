#!/usr/bin/env python3
import json, os, subprocess

s_jsonfile          = "/home/pi/DLNA-Radio/stations.json"
s_rygel_file        = "/home/pi/.config/rygel.conf"
s_youtube_live      = "/home/pi/DLNA-Radio/get_youtube_live.sh"
s_youtube_script    = "/home/pi/DLNA-Radio/get_youtube.sh"
s_youtube_file      = "/home/pi/DLNA-Radio/got_youtube.txt"
s_rygel_lines       = ""
s_config_lines      = ""
i                   = 0
s_rygel_items       = "launch-items="

#os.system("rm -f " + s_rygel_file)
os.system("touch " + s_rygel_file)
os.system("chmod a+w " + s_rygel_file)


with open(s_jsonfile, "r") as json_file:
    data = json.load(json_file)
    
    for c in data['dlna-conf']:
        s_config_lines       += "title="+c["library-name"]+" - @PRETTY_HOSTNAME@\n"
        s_config_lines       += "enabled="+c["library-enabled"]+"\n"    

    for s in data['dlna-stations']:
        i += 1
        s_rygel_items        = s_rygel_items + "station"+str(i)+";"
        s_rygel_lines       += "station"+ str(i) +"-title="+s["name"]+"\n"
        

        if "youtube" in s["url"]:
            if "live" in s["mime"]:            
                os.system(s_youtube_live + " " + s["url"])
                s["mime"] = "audio/mp4"

            else:
                os.system(s_youtube_script + " " + s["url"])
            s_rygel_lines       += "station"+ str(i) +"-mime="+s["mime"]+"\n"

            s_temp_file = open(s_youtube_file, "r")
            s_yt_url = s_temp_file.read()
            s_temp_file.close()
            os.system("rm -f " + s_youtube_file)

            s_rygel_lines       += "station"+ str(i) +"-launch=souphttpsrc is-live=true location="+s_yt_url+" ! qtdemux name=demuxer demuxer.audio_0 ! queue ! avdec_aac ! audioconvert ! audioresample ! avenc_aac ! autoaudiosink\n\n"

        
        else:
            s_rygel_lines       += "station"+ str(i) +"-mime="+s["mime"]+"\n"            
            s_rygel_lines       += "station"+ str(i) +"-launch=souphttpsrc iradio-mode=false is-live=true location="+s["url"]+"\n\n"



s_rygel_head    = "[GstLaunch]\n"+ s_config_lines + "\n"
s_rygel_out     = s_rygel_head + s_rygel_items[:-1] + "\n" + s_rygel_lines


with open(s_rygel_file, "w") as s_file:
        s_file.write(s_rygel_out)

os.system("rygel")
