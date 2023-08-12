#!../bin/python3
import os, subprocess, time, json

DIR_HOME = os.path.expanduser("~")
DIR_APP = f"{DIR_HOME}/python-apps/dlnaradio/app"


s_jsonfile          = f"{DIR_APP}/stations.json"
s_rygel_file        = f"{DIR_HOME}/.config/rygel.conf"
s_youtube_live      = f"{DIR_APP}/get_youtube_live.sh"
s_youtube_script    = f"{DIR_APP}/get_youtube.sh"
s_youtube_file      = f"{DIR_APP}/got_youtube.txt"
s_rygel_lines       = ""
s_config_lines      = ""
i                   = 0
s_rygel_items       = "launch-items="

#os.system("rm -f " + s_rygel_file)
os.system("touch " + s_rygel_file)
os.system("chmod a+r " + s_rygel_file)
os.system("touch " + s_youtube_file)
os.system("chmod a+rw " + s_youtube_file)

time.sleep(10)

with open(s_jsonfile, "r") as json_file:
	data = json.load(json_file)

	for c in data['dlna-conf']:
		s_config_lines       += "title="+c["library-name"]+" - @PRETTY_HOSTNAME@\n"
		s_config_lines       += "enabled="+c["library-enabled"]+"\n"

	for s in data['dlna-stations']:
		i += 1
		s_rygel_items        = s_rygel_items + "station"+str(i)+";"
		s_rygel_lines       += "station"+ str(i) +"-title="+s["name"]+"\n"

		if "metube" in s["url"]:
			if "live" in s["mime"]:
				os.system(s_youtube_live + " " + s["url"])
				s["mime"] = "audio/mp4"

			else:
				os.system(s_youtube_script + " " + s["url"])
				s_rygel_lines       += "station"+ str(i) +"-mime="+s["mime"]+"\n"

				s_temp_file = open(s_youtube_file, "r")
				s_yt_url = s_temp_file.read()
				s_temp_file.close()

			s_rygel_lines += "station"+ str(i) +"-launch=souphttpsrc is-live=true location="+s_yt_url+" ! qtdemux name=demuxer demuxer.audio_0 ! queue ! avdec_aac ! audioconvert ! audioresample ! avenc_aac ! autoaudiosink\n\n"

		else:
			s_rygel_lines += "station"+ str(i) +"-mime="+s["mime"]+"\n"
			s_rygel_lines += "station"+ str(i) +"-dlnaprofile="+s["mime"]+"\n"
			s_rygel_lines += "station"+ str(i) +"-launch=souphttpsrc iradio-mode=true is-live=true automatic-redirect=true location="+s["url"]+"\n\n"



# https://gstreamer.freedesktop.org/documentation/soup/souphttpsrc.html?gi-language=c
# https://stuff.mit.edu/afs/athena/system/amd64_deb50/os/usr/share/gtk-doc/html/gst-plugins-good-plugins-0.10/gst-plugins-good-plugins-souphttpsrc.html
# https://rtist.hcldoc.com/help/index.jsp?topic=%2Forg.eclipse.linuxtools.cdt.libhover.devhelp%2Fgst-plugins-good-plugins-1.0%2Fgst-plugins-good-plugins-souphttpsrc.html

print(s_rygel_lines)

s_rygel_head    = "[General]\nupnp-enabled=true\nenable-transcoding=true\nmedia-engine=librygel-media-engine-gst.so\nlog-level=*:5\nport=1920\n\n[Tracker3]\nenabled=false\n\n[Tracker]\nenabled=false\n\n[MediaExport]\nenabled=false\nuris=@MUSIC@\n\n[GstMediaEngine]\ntranscoders=mp3;lpcm;mp2ts;wmv;aac;avc\n\n[GstLaunch]\n"+ s_config_lines + "\n"
s_rygel_out     = s_rygel_head + s_rygel_items[:-1] + "\n" + s_rygel_lines


with open(s_rygel_file, "w") as s_file:
	s_file.write(s_rygel_out)

os.system("rygel")
