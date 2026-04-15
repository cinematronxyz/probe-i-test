#!/bin/bash

PRINT_GREEN='\033[92m'
PRINT_RESET='\033[0;39m'

echo -e "${PRINT_GREEN}Zapocinjem pripremu za Ubuntu 24.04...${PRINT_RESET}"

echo -e "${PRINT_GREEN}Instalacija zvanicnog DDD-a i Gedit-a...${PRINT_RESET}"
sudo apt-get update
sudo apt-get install -y ddd gedit

if [ -f "ddd_3.3.12-6_amd64.deb" ]; then
    echo -e "${PRINT_GREEN}Izvlacenje FTN konfiguracije iz .deb fajla...${PRINT_RESET}"
    mkdir -p ./temp_extract
    dpkg-deb -x ddd_3.3.12-6_amd64.deb ./temp_extract
    
    sudo cp ./temp_extract/etc/X11/app-defaults/Ddd /etc/X11/app-defaults/Ddd
    rm -rf ./temp_extract
else
    echo "Greska: ddd_3.3.12-6_amd64.deb nije pronadjen u ovom folderu!"
    exit 1
fi

echo -e "${PRINT_GREEN}Podesavanje bojenja sintakse za Gedit...${PRINT_RESET}"
sudo mkdir -p /usr/share/libgedit-gtksourceview-300/language-specs/
sudo cp asm.lang /usr/share/libgedit-gtksourceview-300/language-specs/
sudo chmod 664 /usr/share/libgedit-gtksourceview-300/language-specs/asm.lang

echo -e "${PRINT_GREEN}Azuriranje MIME baze...${PRINT_RESET}"
sudo cp Overrides.xml /usr/share/mime/packages/
sudo update-mime-database /usr/share/mime

echo -e "${PRINT_GREEN}-------------------------------------------------------${PRINT_RESET}"
echo -e "${PRINT_GREEN}GOTOVO! LongU, LongH i registri bi trebali da rade.${PRINT_RESET}"
echo -e "${PRINT_GREEN}Restartujte terminal ili se ponovo prijavite na sistem.${PRINT_RESET}"
