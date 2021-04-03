#!/usr/bin/env python3
import json, os

s_jsonfile          = "/home/lee/DLNA-Radio/stations.json"
s_rygel_file        = "/home/lee/.config/rygel.conf"
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
        s_config_lines       += "title="+c["library-name"]+" on @PRETTY_HOSTNAME@\n"
        s_config_lines       += "enabled="+c["library-enabled"]+"\n"    

    for s in data['dlna-stations']:
        i += 1
        s_rygel_items        = s_rygel_items + "station"+str(i)+";"
        s_rygel_lines       += "station"+ str(i) +"-title="+s["name"]+"\n"
        s_rygel_lines       += "station"+ str(i) +"-mime="+s["mime"]+"\n"
        s_rygel_lines       += "station"+ str(i) +"-launch=souphttpsrc iradio-mode=true is-live=true location="+s["url"]+"\n\n"



s_rygel_head    = "[GstLaunch]\n"+ s_config_lines + "\n"
s_rygel_out     = s_rygel_head + s_rygel_items[:-1] + "\n" + s_rygel_lines


with open(s_rygel_file, "w") as s_file:
        s_file.write(s_rygel_out)

os.system("rygel")
