#!/bin/sh
DISTFILE=mapbbcode-latest.zip
wget -nv http://mapbbcode.org/dist/$DISTFILE
unzip -q $DISTFILE
rm $DISTFILE
cp -r mapbbcode/* root/mapbbcode/
rm -r mapbbcode

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
