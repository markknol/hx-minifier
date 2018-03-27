#!/bin/sh
rm -f Minifier.zip
zip -r Minifier.zip lib run.n haxelib.json README.md
haxelib submit Minifier.zip $HAXELIB_PWD --always