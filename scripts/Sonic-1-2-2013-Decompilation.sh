#!/bin/bash
cd ~/Projects/Sonic-1-2-2013-Decompilation/
rm -Rf build
git pull
git submodule update --init


cmake -B build -DRETRO_DISABLE_PLUS=on
cmake --build build --config release

mkdir -p build/AppDir/usr/bin
mkdir -p build/AppDir/usr/share/applications
mkdir -p build/AppDir/usr/share/icons/hicolor/512x512
cp build/RSDKv4 build/AppDir/usr/bin
cp flatpak/com.sega.Sonic1.svg build/AppDir/usr/share/icons/hicolor/512x512/com.sega.Sonic1.svg

cat > build/AppDir/usr/share/applications/RSDKv4.desktop <<\EOF
[Desktop Entry]
Version=1.0
Name=Sonic the Hedgehog
Exec=RSDKv4
Terminal=false
Icon=com.sega.Sonic1
Type=Application
Categories=Game;
X-AppImage-Integrate=false
EOF


cat > build/AppDir/AppRun <<\EOF
#!/bin/bash
mkdir -p $HOME/.local/share/RetroEngine/Sonic1_RSDKv4/
cd $HOME/.local/share/RetroEngine/Sonic1_RSDKv4/
${0%/*}/usr/bin/RSDKv4
EOF

rm -f ~/Desktop/Sonic1_RSDKv4-x86_64.AppImage
env OUTPUT=~/Desktop/Sonic1_RSDKv4-x86_64.AppImage ~/linuxdeploy-x86_64.AppImage --appdir build/AppDir/ --output appimage
