#!/bin/sh
# Simple script to check music directory

MUSICDIR=/home/.share/Audio/Musique/

###########################
### Functions           ###
###########################

usage(){
    echo "$(gettext 'Usage: checkMusic <dir>')"
    exit 0
}

###################################
### MAIN PROGRAM                ###
###################################
if [ "$1" != "" ]; then
    MUSICDIR=$MUSICDIR/$1
fi    

echo -ne "Nombre d'albums \t\t: "
find $MUSICDIR -mindepth 3 -type d | wc -l

echo -ne "Nombre d'image jpg/JPG \t\t: "
find $MUSICDIR -type f -iname "*.jpg" | wc -l

echo -ne "Nombre d'image jpeg/JPEG \t: "
find $MUSICDIR -type f -iname "*.jpeg" | wc -l

echo -ne "Nombre d'image png/PNG \t\t: "
find $MUSICDIR -type f -iname "*.png" | wc -l

echo -ne "Nombre d'image gif/GIF \t\t: "
find $MUSICDIR -type f -iname "*.gif" | wc -l

echo -ne "Nombre d'image bmp/BMP \t\t: "
find $MUSICDIR -type f -iname "*.bmp" | wc -l

echo -ne "Nombre de dossiers cachés \t: "
find $MUSICDIR -type d -iname ".*" | wc -l

echo ""
echo "Liste de fichiers images jp*g non conforme : "
find $MUSICDIR -type f \( -iname "*.jp*g" -and ! -name "cover.*" \)

echo ""
echo "Liste de fichiers images png non conforme : "
find $MUSICDIR -type f \( -iname "*.png" -and ! -name "cover.*" \)

echo ""
echo "Liste de fichiers images gif non conforme : "
find $MUSICDIR -type f \( -iname "*.gif" -and ! -name "cover.*" \)

echo ""
echo "Liste de fichiers non conforme : "
find $MUSICDIR -mindepth 3 -type f | grep -iEv ".mp3|.mpc|.ogg|.flac|cover.jpg|cover.jpeg|cover.png|cover|cover.gif"

echo ""
echo "Liste des repertoires sans images "
find $MUSICDIR -mindepth 3  -type d | sort | while read dir; do
    IMG=$(ls -l "$dir" | grep -E "jpg|jpeg|png|gif" | wc -l ) 
    if [ $IMG -lt 1 ]; then
        echo $dir
    fi
done

