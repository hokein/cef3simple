#!/usr/bin/env bash

mkdir -p build
touch build/touched # for silencing the next line, in case the folder was just created
rm -r build/*
cd build

echo "Building cefsimple"
g++ -c ../src/*.cpp \
  -I $1 \
  `pkg-config --cflags gtk+-2.0`

echo "Linking..."
g++ *.o \
  $1/out/Release/obj.target/libcef_dll_wrapper.a \
  -o cef3simple \
  `pkg-config --cflags gtk+-2.0` \
  -L $1/Release \
  -ldl \
  -lcef \
  -Wl,-rpath=$1/Release

echo "Copying cef resources"
rm *.o
cp -r $1/Resources/* .
cp -r $1/Release/*.so .
