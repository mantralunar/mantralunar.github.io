#!/bin/bash
cmake -B build -DRETRO_DISABLE_PLUS=on
cmake --build build --config release

mkdir -p build/AppDir/usr/share/applications/

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

~/linuxdeploy-x86_64.AppImage --appdir build/AppDir/ --executable build/RSDKv4 --icon-file flatpak/com.sega.Sonic1.svg --plugin checkrt --output appimage
