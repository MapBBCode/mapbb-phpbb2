#!/bin/sh
DISTFILE=mapbbcode-latest.zip
rm -rf root/mapbbcode
wget -nv http://mapbbcode.org/dist/$DISTFILE
unzip -q $DISTFILE
rm $DISTFILE
mv mapbbcode root/

iconv -f UTF-8 -t WINDOWS-1251 root/mapbbcode/lang/Russian.js > Russian.js
iconv -f UTF-8 -t WINDOWS-1251 root/mapbbcode/lang/Russian.Config.js > Russian.Config.js
mv Russian*.js root/mapbbcode/lang/

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
