#!/bin/bash

git -c submodule."Externals/Qt".update=none \
-c submodule."Externals/FFmpeg-bin".update=none \
-c submodule."Externals/libadrenotools".update=none \
submodule update --init --recursive \
&& git pull --recurse-submodules


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

linuxdeploy-x86_64.AppImage --appdir AppDir --plugin qt --plugin checkrt --output appimage
