#!/bin/bash
# List Internet Radio Streams to DLNA Directory with Rygel


echo '
######  #       #     #    #            ######     #    ######    ###   #######
#     # #       ##    #   # #           #     #   # #   #     #    #    #     #
#     # #       # #   #  #   #          #     #  #   #  #     #    #    #     #
#     # #       #  #  # #     #  #####  ######  #     # #     #    #    #     #
#     # #       #   # # #######         #   #   ####### #     #    #    #     #
#     # #       #    ## #     #         #    #  #     # #     #    #    #     #
######  ####### #     # #     #         #     # #     # ######    ###   #######
'


# Choose between Older Raspberry Pi (Bullseye) and Newer (Bookworm)

PS3='Please select the version of Debian your system is using: '
options=("Raspberry Pi OS Bullseye [Debian 11]" "Raspberry Pi OS Bookworm [Debian 12]" "Linux Mint 21" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Raspberry Pi OS Bullseye [Debian 11]")
            echo -e "\n\nOld School! I like it!\n\n"
            source "install-deb11.sh"
	    break
            ;;
        "Raspberry Pi OS Bookworm [Debian 12]")
            echo -e "\n\nToo cool for school!\n\n"
            source "install-deb12.sh"
	    break
            ;;
        "Linux Mint 21")
            echo -e "\n\nRefreshing! But not quite ready just yet.\n\n"
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

watch systemctl status dlna.service
