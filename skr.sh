#!/bin/bash

echo "Pokretanje instalacije za AR/FTN softver..."

if [ ! -d /usr/share/gtksourceview-4/language-specs ]; then
    echo "Ne mogu da nadjem gtksourceview language-specs direktorijum, kreiram /usr/share/gtksourceview-4/language-specs"
    sudo mkdir -p /usr/share/gtksourceview-4/language-specs
fi

echo "Kopiranje asm.lang u /usr/share/gtksourceview-4/language-specs..."
sudo cp asm.lang /usr/share/gtksourceview-4/language-specs/

echo "Postavljanje Overrides.xml..."
if [ -f Overrides.xml ]; then
    echo "Postojeci Overrides.xml sacuvan kao Overrides.xml.bak"
    sudo cp Overrides.xml Overrides.xml.bak
fi
sudo cp Overrides.xml /usr/share/gtksourceview-4/

echo "Brisanje stare DDD konfiguracije..."
rm -rf ~/.ddd

echo "Instalacija potrebnih paketa..."
sudo apt-get update

BASIC_PACKAGES="gdebi gcc diffutils grep sed ddd ddd-doc expect gcc-13-multilib gcc-multilib lib32asan8 lib32atomic1 lib32gcc-13-dev lib32gcc-s1 lib32gomp1 lib32itm1 lib32quadmath0 lib32stdc++6 lib32ubsan1 libc6-dev-x32 libc6-i386 libc6-x32 libmotif-common libssh2-1t64 libutempter0 libx32asan8 libx32atomic1 libx32gcc-13-dev libx32gcc-s1 libx32gomp1 libx32itm1 libx32quadmath0 libx32stdc++6 libx32ubsan1 libxm4 mailcap mc mc-data tcl-expect xfonts-100dpi xterm"

DEV_PACKAGES="automake bison cdbs debhelper flex info libmotif-dev libreadline-dev libtool libxaw7-dev texinfo quilt dh-autoreconf"

sudo apt-get install -y $BASIC_PACKAGES $DEV_PACKAGES

echo "Sve gotovo! Pokreni 'ddd' i proveri."
echo "Ako ddd ne radi odmah, odjavi se i ponovo uloguj."