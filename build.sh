#!/bin/sh
TARGET=dist/mapbbcode_mod.zip
DIR=mapbbcode
mkdir $DIR
cp install.mod $DIR
cp README.md $DIR
cp -r root $DIR
rm $TARGET
zip -qr $TARGET $DIR
rm -r $DIR
