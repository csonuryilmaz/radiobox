#!/bin/bash

VERSION='0.2'
RADIOS=(
    "Radyo Voyage|http://voyagewmp.radyotvonline.com:80/"
    "Lounge Fm|http://37.1.144.106:9003/"
    "CNN Türk|http://radyo.dogannet.tv/cnnturk"
    "NTV Radyo|http://ntvrdsc.radyotvonline.com/"
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
    echo ""
    echo "List of Radio Stations"
    echo "----------------------"
    IFS=""
    RADIO_INDEX=0
    for RADIO in ${RADIOS[@]}; do
        RADIO_INDEX=$((RADIO_INDEX+1));
        echo -e "${RADIO_INDEX} \t >>> ${RADIO}"
    done
    echo ""
    read -p "Please select number to play(1-${RADIO_INDEX}):" SELECTED_RADIO_INDEX
    SELECTED_RADIO_INDEX=$((SELECTED_RADIO_INDEX-1))
    IFS=';' 
    RADIO_URL=$(echo "${RADIOS[SELECTED_RADIO_INDEX]}" | cut -d'|' -f2)
    RADIO_NAME=$(echo "${RADIOS[SELECTED_RADIO_INDEX]}" | cut -d'|' -f1)
    echo ""
    echo "Playing: ${RADIO_NAME}"
    mpv --no-ytdl $RADIO_URL
    read -rsp "Press ENTER to go back main menu ..."
    showOptions
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

isMpvInstalled
echo "Radiobox is ready to play."
read -rsp "Press ENTER to continue main menu ..."
showOptions