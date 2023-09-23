#!/bin/bash

cd ~/Desktop/ppsspp
rm -Rf Build
git pull

git submodule update --init --recursive


mkdir Build && cd Build

cmake .. \
    -Wno-dev \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
    -DHEADLESS=ON \
    -DOpenGL_GL_PREFERENCE=GLVND \
    -DUSE_SYSTEM_FFMPEG=OFF \
    -DUSE_SYSTEM_LIBZIP=ON \
    -DUSE_SYSTEM_SNAPPY=ON \
    -DUSE_SYSTEM_ZSTD=ON \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DUSING_QT_UI=OFF

make -j$(nproc)
make install DESTDIR=AppDir


mv AppDir/usr/share/ppsspp/assets AppDir/usr/bin/assets

env OUTPUT=~/Desktop/PPSSPPSDL-x86_64.AppImage ~/linuxdeploy-x86_64.AppImage --appdir AppDir --output appimage
