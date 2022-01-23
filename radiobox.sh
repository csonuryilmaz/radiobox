#!/bin/bash

VERSION='0.3'
RADIOS=(
    # News
    #"CNN Türk|http://radyo.dogannet.tv/cnnturk"
    "NTV Radyo|http://ntvrdsc.radyotvonline.com/"
    #"Habertürk|http://mn-i.mncdn.com/haberturkradyo/htradyo/playlist.m3u8"
    #"Trt Haber|http://sr1.netmedya.org:9170/"
    #"Trt Radyo 1|http://trtcanlifm-lh.akamaihd.net/i/RADYO1_1@182345/master.m3u8"
    #"Bloomberg|http://mn-l.mncdn.com/bloomberghtradyo/bloomberghtradyo/playlist.m3u8"
    #"Radyo D|http://radyo.dogannet.tv/radyod"
    #"Trt Fm|http://trtcanlifm-lh.akamaihd.net/i/TRTFM_1@181846/master.m3u8"
    # Concentration
    "Radyo Voyage|http://voyagewmp.radyotvonline.com:80/"
    #"Lounge Fm|http://37.1.144.106:9003/"
    # Mixed
    "Pal Station|http://shoutcast.radyogrup.com:1020/"
    "Metro Fm|http://playerservices.streamtheworld.com/api/livestream-redirect/METRO_FM_SC"
    #"Power Fm|http://195.142.3.35/power/PowerFM_mpeg_128_home/icecast.audio?"
    #"Mydonose|http://playerservices.streamtheworld.com/api/livestream-redirect/RADIO_MYDONOSE_SC"
    #"Kral World|http://dygwebradios.radyotvonline.com/kralworldsmil/smil:kralworlddigital.smil/chunklist_w1539152345_b128000.m3u8"
    #"Number One|http://46.20.4.60:80/"
    "Virgin Radio|http://playerservices.streamtheworld.com/api/livestream-redirect/VIRGIN_RADIO_SC"
    "Joy Fm|http://playerservices.streamtheworld.com/api/livestream-redirect/JOY_FM_SC"
    "Pal Dance|http://shoutcast.radyogrup.com:2040/"
    #"Number One Dance|http://nr1digitalsc.radyotvonline.com:80/stream/215/"
    "Pal Orient|http://shoutcast.radyogrup.com:1050/"
    "World Hits|http://37.247.98.8/stream/34/.mp3"
    "Joy Jazz|http://playerservices.streamtheworld.com/api/livestream-redirect/JOY_JAZZ_SC"
    "Radyo 7|http://canliyayin.radyo7.com/"
    #"Polis Radyosu|http://live4.radyotvonline.com:8040/"
    # Slow
    #"Kral Love|https://ssldyg.radyotvonline.com/kralweb/smil:klove.smil/chunklist_w1628931285_b64000.m3u8"
    #"Number One Slow|http://nr1digitalsc.radyotvonline.com:80/stream/224/"
    #"Power Love|http://195.142.3.35/power/PowerLove_mpeg_128_home/icecast.audio?"
    #"Slow Türk|https://radyo.dogannet.tv/slowturk"
    #"Joy Türk Akustik|http://playerservices.streamtheworld.com/api/livestream-redirect/JOYTURK_AKUSTIK_SC"
    #"Power Türk Akustik|http://195.142.3.35/power/PowerTurkAkustik_mpeg_128_home/icecast.audio?"
    "Pal Akustik|http://shoutcast.radyogrup.com:2030/"
    "Pal Slow|http://shoutcast.radyogrup.com:2020/"
    # Nostalgie
    #"Kral 90lar|https://ssldyg.radyotvonline.com/kralweb/smil:k90s.smil/chunklist_w223351258_b64000.m3u8"
    "Retro Türk|http://playerservices.streamtheworld.com/api/livestream-redirect/RETROTURK_SC"
    "Radyo 7 Nostalji|http://37.247.98.8/stream/25/.mp3"
    "Radyo Dejavu|http://radyodejavu.canliyayinda.com:8054/"
    "Pal Nostalji|http://shoutcast.radyogrup.com:1010/"
    "X Nostalji|http://46.20.13.51:1140/"
    "Kral 45lik|https://ssldyg.radyotvonline.com/kralweb/smil:kral45lik.smil/chunklist_w1544647566_b64000.m3u8"
    "Radyo 45lik|http://104.236.16.158:3060/"
)

function isMpvInstalled {
    echo "Checking is mpv installed ..."
    mpv --version
    if [ $? -ne 0 ]; then
        echo ""
        echo "Error: You must install mpv player!"
        echo "* Official website: http://mpv.io"
        echo "* Windows builds: http://mpv.srsfckn.biz/"
        echo ""
        read -rsp "Press ENTER to exit"
        echo ""
        exit $?
    fi
}

function selectRadioStation {
    clear
    echo "List of Radio Stations"
    echo "----------------------"
    IFS=""
    RADIO_INDEX=0
    RADIO_TABLE=""
    for RADIO in ${RADIOS[@]}; do
        RADIO_INDEX=$((RADIO_INDEX+1));
        RADIO_NAME=$(echo "${RADIO}" | cut -d'|' -f1)
        RADIO_TABLE="$RADIO_TABLE $(printf '(%2s)' ${RADIO_INDEX})"
        RADIO_TABLE="$RADIO_TABLE $(printf '%2s \\n' ${RADIO_NAME})"
    done
    printf "${RADIO_TABLE}" | column -c 100
    echo ""
    echo "(b)  Back to main menu ..."
    echo ""
    read -p "Please select number to play(1-${RADIO_INDEX}):" SELECTED_OPTION
    clear
    if [[ $SELECTED_OPTION == "B" || $SELECTED_OPTION == "b" ]]; then
        showOptions
    else
        SELECTED_RADIO_INDEX=$SELECTED_OPTION
        # play
        SELECTED_RADIO_INDEX=$((SELECTED_RADIO_INDEX-1))
        IFS=';' 
        RADIO_URL=$(echo "${RADIOS[SELECTED_RADIO_INDEX]}" | cut -d'|' -f2)
        RADIO_NAME=$(echo "${RADIOS[SELECTED_RADIO_INDEX]}" | cut -d'|' -f1)
        echo ""
        echo "Playing: ${RADIO_NAME}"
        mpv --no-ytdl $RADIO_URL
        selectRadioStation
    fi
}

function playRandomStation {
    echo "2. Sorry! Not implemented yet."
    read -rsp "Press ENTER to continue ..."
    showOptions
}

function searchRadioStation {
    echo "3. Sorry! Not implemented yet."
    read -rsp "Press ENTER to continue ..."
    showOptions
}

function showOptions {
    clear
    echo -e "RadioBox $VERSION \t Command line radio player for coder geeks :)"
    echo ""
    echo "Choose an option to continue:"
    options=("Select Radio Station" "Play Random Station" "Search Radio Station" "Quit")
    select option in "${options[@]}"
    do
        case $option in
            "Select Radio Station")
                selectRadioStation
            break
                ;;
            "Play Random Station")
                playRandomStation
            break
                ;;
            "Search Radio Station")
                searchRadioStation
            break
                ;;
            "Quit")
            echo "Bye"
                break
                ;;
            *) echo invalid option;;
        esac
    done
}

clear
isMpvInstalled
echo "Radiobox is ready to play."
read -rsp "Press ENTER to continue main menu ..."
showOptions