#!/usr/bin/env bash

CONFIG_FILE="${XDG_CONFIG_HOME}/qBittorrent.conf"

if [[ ! -e "$CONFIG_FILE" ]]; then
    echo "* Creating default qBittorrent config"
    cat <<EOF > "$CONFIG_FILE"
[AutoRun]
enabled=false
program=

[LegalNotice]
Accepted=true

[Preferences]
Connection\UPnP=false
Connection\PortRangeMin=6881
Downloads\SavePath=/videos/downloads/qbittorrent/
Downloads\ScanDirsV2=@Variant(\0\0\0\x1c\0\0\0\0)
Downloads\TempPath=/downloads/incomplete/
WebUI\Address=*
WebUI\ServerDomains=*
EOF
fi
