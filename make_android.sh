#!/bin/sh
SRCDIR=/Users/song/Projects/androidstudio/ju/LuaView/luajit-2.0
DIR=/Users/song/Projects/androidstudio/ju/LuaView/luajit-2.0/builds

cd "$SRCDIR"

NDK=/Users/song/AndroidNDK
NDKABI=9
NDKVER=$NDK/toolchains/arm-linux-androideabi-4.9
NDKP=$NDKVER/prebuilt/darwin-x86_64/bin/arm-linux-androideabi-
NDKF="--sysroot $NDK/platforms/android-$NDKABI/arch-arm"

#Android/ARM, armeabi (ARMv5TE soft-float), Android 2.2+ (Froyo)
DESTDIR=$DIR/android/armeabi
rm "$DESTDIR"/*.a
make clean
make HOST_CC="gcc -m32" CROSS=$NDKP TARGET_SYS=Linux TARGET_FLAGS="$NDKF"

if [ -f $SRCDIR/src/libluajit.a ]; then
mkdir -p $DESTDIR
cp $SRCDIR/src/{libluajit.a,lua.h,lauxlib.h,lua.hpp,luaconf.h,luajit.h,lualib.h} $DESTDIR
fi;

# Android/ARM, armeabi-v7a (ARMv7 VFP), Android 4.0+ (ICS)
NDKARCH="-march=armv7-a -Wl,--fix-cortex-a8"
DESTDIR=$DIR/android/armeabi-v7a
rm "$DESTDIR"/*.a
make clean
make HOST_CC="gcc -m32" CROSS=$NDKP TARGET_SYS=Linux TARGET_FLAGS="$NDKF $NDKARCH"

if [ -f $SRCDIR/src/libluajit.a ]; then
mkdir -p $DESTDIR
cp $SRCDIR/src/{libluajit.a,lua.h,lauxlib.h,lua.hpp,luaconf.h,luajit.h,lualib.h} $DESTDIR
fi;

# Android/x86, x86 (i686 SSE3), Android 4.0+ (ICS)
NDKABI=14
DESTDIR=$DIR/android/x86
NDKVER=$NDK/toolchains/x86-4.9
NDKP=$NDKVER/prebuilt/darwin-x86_64/bin/i686-linux-android-
NDKF="--sysroot $NDK/platforms/android-$NDKABI/arch-x86"
rm "$DESTDIR"/*.a
make clean
make HOST_CC="gcc -m32" CROSS=$NDKP TARGET_SYS=Linux TARGET_FLAGS="$NDKF"

if [ -f $SRCDIR/src/libluajit.a ]; then
mkdir -p $DESTDIR
cp $SRCDIR/src/{libluajit.a,lua.h,lauxlib.h,lua.hpp,luaconf.h,luajit.h,lualib.h} $DESTDIR
fi;

make clean