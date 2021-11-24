#!/bin/bash

version=`jq -r ".version" < info.json`
path="combat-tweaks_$version"

mkdir -p "build/$path"
cp -r *.lua info.json locale "build/$path/"
cd build
zip -r --compression-method=deflate "$path.zip" "$path"
