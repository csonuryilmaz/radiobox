#!/bin/bash

VERSION='0.1'
MPV_PLAY='mpv --no-ytdl'
RADIO_STATION='http://voyagewmp.radyotvonline.com:80/'

function isMpvInstalled {
    echo "[**] Checking is mpv installed ..."
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

clear
echo -e "RadioBox $VERSION \t Command line radio player for coder geeks :) \n"

isMpvInstalled
echo "[OK] Mpv is found. RadioBox is ready for playing."
`${MPV_PLAY} ${RADIO_STATION}`