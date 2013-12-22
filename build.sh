#!/bin/sh
DISTFILE=mapbbcode-latest.zip
rm -rf root/mapbbcode
wget -nv http://mapbbcode.org/dist/$DISTFILE
unzip -q $DISTFILE
rm $DISTFILE
mv mapbbcode root/

iconv -f UTF-8 -t WINDOWS-1251 root/mapbbcode/lang/ru.js > ru.js
iconv -f UTF-8 -t WINDOWS-1251 root/mapbbcode/lang/ru.config.js > ru.config.js
mv ru*.js root/mapbbcode/lang/
printf "5d\nw\n" | ed root/mapbbcode/mapbbcode-window.html

TARGET=dist/mapbbcode_mod.zip
DIR=mapbbcode
mkdir $DIR
cp *.mod $DIR
cp README.md $DIR
cp -r root $DIR
rm $TARGET
zip -qr $TARGET $DIR
rm -r $DIR
rm -r root/mapbbcode
