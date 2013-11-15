#!/bin/sh
DISTFILE=mapbbcode-latest.zip
wget -nv http://mapbbcode.org/dist/$DISTFILE
unzip -q $DISTFILE
rm $DISTFILE
cp -r mapbbcode/* root/mapbbcode/
rm -r mapbbcode

iconv -f UTF-8 -t WINDOWS-1251 root/mapbbcode/lang/Russian.js > Russian.js
iconv -f UTF-8 -t WINDOWS-1251 root/mapbbcode/lang/Russian.Config.js > Russian.Config.js
mv Russian*.js root/mapbbcode/lang/

TARGET=dist/mapbbcode_mod.zip
DIR=mapbbcode
mkdir $DIR
cp install.mod $DIR
cp README.md $DIR
cp -r root $DIR
cp -r upgrade $DIR
rm $TARGET
zip -qr $TARGET $DIR
rm -r $DIR
