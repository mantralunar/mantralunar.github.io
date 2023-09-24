#!/bin/bash
cd ~/Desktop/dolphin
rm -Rf ~/Desktop/dolphin/Build
git pull

git submodule update --init --recursive Externals/fmt Externals/mGBA Externals/spirv_cross Externals/zlib-ng Externals/libspng Externals/VulkanMemoryAllocator Externals/cubeb Externals/implot Externals/gtest Externals/rcheevos

git pull --recurse-submodules


mkdir Build && cd Build
cmake .. -DLINUX_LOCAL_DEV=true -DCMAKE_INSTALL_PREFIX=/usr
make -j$(nproc)
make install DESTDIR=AppDir


mv AppDir/usr/share/dolphin-emu/sys AppDir/usr/bin/Sys
rm AppDir/usr/share/applications/dolphin-emu.desktop
cat > AppDir/usr/share/applications/dolphin-emu.desktop <<\EOF
[Desktop Entry]
Version=1.0
Icon=dolphin-emu
Exec=dolphin-emu
Terminal=false
Type=Application
Categories=Game;Emulator;
Name=Dolphin Emulator
GenericName=Wii/GameCube Emulator
Comment=A Wii/GameCube Emulator
EOF


env OUTPUT=~/Desktop/Dolphin_Emulator-x86_64.AppImage ~/linuxdeploy-x86_64.AppImage --appdir AppDir --plugin qt --output appimage
