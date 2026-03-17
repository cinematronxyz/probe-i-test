#!/bin/bash
set -e

echo -e "\033[92mPokretanje instalacije za AR/FTN softver...\033[0m"

# --- Detekcija gtksourceview verzije ---
if [ -d /usr/share/gtksourceview-4/language-specs ]; then
    GTK_DIR="/usr/share/gtksourceview-4/language-specs"
elif [ -d /usr/share/gtksourceview-3.0/language-specs ]; then
    GTK_DIR="/usr/share/gtksourceview-3.0/language-specs"
elif [ -d /usr/share/gtksourceview-2.0/language-specs ]; then
    GTK_DIR="/usr/share/gtksourceview-2.0/language-specs"
else
    echo -e "\033[93mNe mogu da nadjem gtksourceview language-specs direktorijum, kreiram /usr/share/gtksourceview-4/language-specs\033[0m"
    GTK_DIR="/usr/share/gtksourceview-4/language-specs"
    sudo mkdir -p "$GTK_DIR"
fi

echo -e "\033[92mKopiranje asm.lang u $GTK_DIR...\033[0m"
sudo cp asm.lang "$GTK_DIR/"
sudo chmod 664 "$GTK_DIR/asm.lang"

# --- Overrides.xml ---
MIME_DIR="/usr/share/mime/packages"
echo -e "\033[92mKopiranje ili azuriranje Overrides.xml...\033[0m"
if [ ! -f "$MIME_DIR/Overrides.xml" ]; then
    sudo cp Overrides.xml "$MIME_DIR/"
else
    sudo sh -c "cat Overrides.xml >> $MIME_DIR/Overrides.xml"
fi
sudo update-mime-database /usr/share/mime

# --- Brisanje stare DDD konfiguracije ---
echo -e "\033[92mBrisanje stare DDD konfiguracije...\033[0m"
rm -rf ~/.ddd
sudo rm -f /etc/X11/app-defaults/Ddd 2>/dev/null || true

# --- Instalacija potrebnih paketa ---
echo -e "\033[92mInstalacija potrebnih paketa...\033[0m"
sudo apt-get update
sudo apt-get install -y \
    mc gdebi gcc gcc-multilib libc6-dev-i386 xfonts-100dpi expect \
    diffutils grep sed xterm ddd ddd-doc

echo -e "\033[92mSve gotovo! Pokreni 'ddd' i proveri.\033[0m"
echo -e "\033[93mAko ddd ne radi odmah, odjavi se i ponovo uloguj.\033[0m"