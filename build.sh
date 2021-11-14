#!/bin/bash

path="combat-tweaks_1.0.0"

mkdir -p "build/$path"
cp -r *.lua info.json locale "build/$path/"
cd build
zip -r --compression-method=deflate "$path.zip" "$path"
